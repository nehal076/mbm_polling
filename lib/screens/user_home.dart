import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbm_voting/common/shared.dart';
import 'package:mbm_voting/models/all_active_polls.dart';
import 'package:mbm_voting/models/registration.dart';
import 'package:mbm_voting/services/repository.dart';
import 'package:mbm_voting/widgets/drawer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
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
        title: const Text('User Home'),
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
              title: Text(polls[index].ques),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Alert(
                  context: context,
                  desc: polls[index].ques,
                  buttons: [
                    DialogButton(
                      child: const Text(
                        "YES",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        MySharedPreferences.instance
                            .getStringValue("rollNumber")
                            .then((rollNumber) {
                          _callCreateVote(
                              polls[index].pollId, rollNumber, true);

                          Navigator.pop(context);
                        });
                      },
                      width: 120,
                    ),
                    DialogButton(
                      child: const Text(
                        "NO",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        MySharedPreferences.instance
                            .getStringValue("rollNumber")
                            .then((rollNumber) {
                          _callCreateVote(
                              polls[index].pollId, rollNumber, false);

                          Navigator.pop(context);
                        });
                      },
                      width: 120,
                    ),
                  ],
                ).show();
              },
            );
          },
          itemCount: polls.length,
        ),
      ),
      drawer: const MyDrawer(),
    );
  }

  _callCreateVote(pollId, rollNumber, bool vote) async {
    Map<String, dynamic> request = {
      "params": [pollId, vote]
    };

    CommonResponse response = await repo.createVote(request, postParams: {
      "rollNo": rollNumber,
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
            onPressed: () => Navigator.pop(context),
            width: 120,
          )
        ],
      ).show();
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        desc: response.message,
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
}
