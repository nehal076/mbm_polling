import 'package:flutter/material.dart';
import 'package:mbm_voting/common/shared.dart';
import 'package:mbm_voting/models/get_all_votes.dart';
import 'package:mbm_voting/services/repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class MyVotes extends StatefulWidget {
  const MyVotes({Key? key}) : super(key: key);

  @override
  State<MyVotes> createState() => _MyVotesState();
}

class _MyVotesState extends State<MyVotes> {
  Repository repo = Repository();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    _callMyVotesApi();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _callMyVotesApi();
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  List<Message> polls = [];
  @override
  void initState() {
    _callMyVotesApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Votes'),
      ),
      body: SmartRefresher(
        header: const MaterialClassicHeader(),
        enablePullDown: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.poll),
              title: Text('Poll ID (' +
                  polls[index].pollId +
                  '): You voted ' +
                  polls[index].ans.toString()),
              onTap: () {},
            );
          },
          itemCount: polls.length,
        ),
      ),
    );
  }

  _callMyVotesApi() async {
    polls = [];
    await MySharedPreferences.instance
        .getStringValue("rollNumber")
        .then((rollNumber) async {
      Map<String, dynamic> request = {
        "rollNo": rollNumber,
      };

      GetAllVotesByVoter response = await repo.getAllVotesByVoter(request);

      if (response.success == true) {
        setState(() {
          for (var element in response.message ?? []) {
            polls.add(element);
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
    });
  }
}
