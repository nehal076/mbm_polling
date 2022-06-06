import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbm_voting/common/shared.dart';
import 'package:mbm_voting/models/get_all_votes.dart';
import 'package:mbm_voting/services/repository.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

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
        child: polls.isNotEmpty
            ? Container(
                margin: const EdgeInsets.only(top: 10),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            polls[index].ans == true
                                ? CupertinoIcons.checkmark_alt_circle_fill
                                : CupertinoIcons.checkmark_circle_fill,
                            color: polls[index].ans == true
                                ? Colors.green[800]
                                : Colors.red[800],
                          ),
                        ],
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            polls[index].ques + '',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          Row(
                            children: [
                              const Text(
                                'You voted ',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                polls[index].ans == true ? "\"Yes\"" : "\"No\"",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ).py8(),
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  'Txn Id: ${polls[index].txnId}',
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  softWrap: false,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  Clipboard.setData(
                                    ClipboardData(text: polls[index].txnId),
                                  ).then((_) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            "Transaction Id copied to clipboard"),
                                      ),
                                    );
                                  });
                                },
                                icon: const Icon(Icons.copy),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: polls.length,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.blueGrey,
                    );
                  },
                ),
              )
            : const Center(
                child: Text(
                  "You have not voted for any poll yet!",
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
    });
  }
}
