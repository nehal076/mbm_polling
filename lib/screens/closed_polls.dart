import 'package:flutter/material.dart';
import 'package:mbm_voting/models/all_active_polls.dart';
import 'package:mbm_voting/models/get_result_by_poll_id.dart';
import 'package:mbm_voting/services/repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ClosedPolls extends StatefulWidget {
  const ClosedPolls({Key? key}) : super(key: key);

  @override
  _ClosedPollsState createState() => _ClosedPollsState();
}

class _ClosedPollsState extends State<ClosedPolls> {
  Repository repo = Repository();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    _callClosedPollsApi();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _callClosedPollsApi();
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  List<Message> polls = [];
  @override
  void initState() {
    _callClosedPollsApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Closed Polls'),
      ),
      body: SmartRefresher(
        header: const MaterialClassicHeader(),
        enablePullDown: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: polls.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.poll),
                    title: Text(polls[index].ques),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      _callGetResultByPollId(polls[index].pollId);
                    },
                  );
                },
                itemCount: polls.length,
              )
            : const Center(
                child: Text(
                  "No closed polls yet!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
      ),
    );
  }

  _callClosedPollsApi() async {
    polls = [];

    AllActivePolls response = await repo.allClosedPolls();

    if (response.success == true) {
      setState(() {
        if (response.message is List) {
          for (var element in response.message) {
            polls.add(element);
          }
        }
      });
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        desc: response.message.toString(),
        buttons: [
          DialogButton(
            child: const Text(
              "Okay",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }

  _callGetResultByPollId(pollId) async {
    Map<String, dynamic> request = {
      "pollId": pollId,
    };

    GetResultByPollId response = await repo.getResultByPollId(request);

    if (response.success == true) {
      Alert(
        context: context,
        desc: "Poll Result \nYes : " +
            response.message.yes.toString() +
            "\nNo : " +
            response.message.no.toString(),
        buttons: [
          DialogButton(
            child: const Text(
              "Okay",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        desc: response.message.toString(),
        buttons: [
          DialogButton(
            child: const Text(
              "Okay",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    }
  }
}
