import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbm_voting/models/all_active_polls.dart';
import 'package:mbm_voting/models/registration.dart';
import 'package:mbm_voting/services/repository.dart';
import 'package:mbm_voting/widgets/admin_drawer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  Repository repo = Repository();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    _callActivePollsApi();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  List<Message> polls = [];
  @override
  void initState() {
    _callActivePollsApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home'),
      ),
      body: SmartRefresher(
        header: const MaterialClassicHeader(),
        enablePullDown: true,
        controller: _refreshController,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: polls.isNotEmpty
            ? ListView.builder(
                itemCount: polls.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const Icon(Icons.poll),
                    title: Text(polls[index].ques),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Alert(
                        context: context,
                        type: AlertType.info,
                        desc: "Close this Poll?",
                        buttons: [
                          DialogButton(
                            child: const Text(
                              "Cancel",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            width: 120,
                          ),
                          DialogButton(
                            color: Colors.redAccent,
                            child: const Text(
                              "Close Now",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {
                              _callClosePollApi(polls[index].pollId);
                              Navigator.pop(context);
                            },
                            width: 120,
                          )
                        ],
                      ).show();
                    },
                  );
                },
              )
            : const Center(
                child: Text(
                  "No Active Polls!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
              ),
      ),
      drawer: const AdminDrawer(),
    );
  }

  _callActivePollsApi() async {
    polls = [];

    AllActivePolls response = await repo.allActivePolls();

    if (response.success == true) {
      setState(() {
        for (var element in response.message ?? []) {
          polls.add(element);
        }
      });
    }
  }

  _callClosePollApi(pollId) async {
    Map<String, dynamic> request = {
      "params": [pollId]
    };

    CommonResponse response = await repo.closePoll(request, postParams: {
      "rollNo": "admin",
    });

    if (response.success == true) {
      Alert(
        context: context,
        type: AlertType.success,
        desc: response.message,
        buttons: [
          DialogButton(
            child: const Text(
              "Okay",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              setState(() {
                _callActivePollsApi();
              });
              Navigator.pop(context);
            },
            width: 120,
          ),
        ],
      ).show();
    }
  }
}
