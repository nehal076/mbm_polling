import 'package:flutter/material.dart';
import 'package:mbm_voting/models/registration.dart';
import 'package:mbm_voting/services/repository.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:velocity_x/velocity_x.dart';

class CreatePoll extends StatefulWidget {
  const CreatePoll({Key? key}) : super(key: key);

  @override
  _CreatePollState createState() => _CreatePollState();
}

class _CreatePollState extends State<CreatePoll> {
  final _createPollKey = GlobalKey<FormState>();

  final TextEditingController _question = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create a Poll'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight - 30,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/dsc.png',
                  height: 150,
                  width: 150,
                  fit: BoxFit.cover,
                ),
                const Text(
                  'Create a Poll',
                  style: TextStyle(fontSize: 24),
                ).p20(),
                Form(
                  key: _createPollKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Question',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ).px20().pOnly(top: 20),
                      TextFormField(
                        controller: _question,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: 'Enter question',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Question cannot be empty";
                          }
                        },
                      ).px20(),
                    ],
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: ButtonTheme(
                      minWidth: context.screenWidth - 50,
                      height: 60,
                      child: MaterialButton(
                        onPressed: () {
                          if (_createPollKey.currentState!.validate()) {
                            Alert(
                              context: context,
                              type: AlertType.info,
                              desc: "Create a poll? \n\n" + _question.text,
                              buttons: [
                                DialogButton(
                                  child: const Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  width: 120,
                                ),
                                DialogButton(
                                  color: Colors.green,
                                  child: const Text(
                                    "Create",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    _callCreatePoll(_question.text);
                                    Navigator.pop(context);
                                  },
                                  width: 120,
                                )
                              ],
                            ).show();
                          }
                        },
                        color: Colors.green,
                        child: const Text(
                          'Create',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ).pOnly(bottom: context.screenHeight > 600 ? 40 : 10),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _callCreatePoll(question) async {
    Map<String, dynamic> request = {
      "params": [question]
    };
    Repository repo = Repository();
    CommonResponse response = await repo.createPoll(request, postParams: {
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
}
