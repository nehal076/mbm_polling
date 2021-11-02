import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbm_voting/models/registration.dart';
import 'package:mbm_voting/screens/login_screen.dart';
import 'package:mbm_voting/services/repository.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:velocity_x/velocity_x.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _registerationKey = GlobalKey<FormState>();
  final TextEditingController _rollNumber = TextEditingController();
  final TextEditingController _emailId = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text('Studypods Blockchain'),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height - kToolbarHeight,
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
                  'Register',
                  style: TextStyle(fontSize: 24),
                ).p20(),
                Form(
                  key: _registerationKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Roll Number',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ).px20().pOnly(top: 20),
                      TextFormField(
                        controller: _rollNumber,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: 'Enter your roll number',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Roll number cannot be empty";
                          }
                        },
                      ).px20(),
                      const Text(
                        'Email ID',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ).px20().pOnly(top: 20),
                      TextFormField(
                        controller: _emailId,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: 'Enter your email id',
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email id cannot be empty";
                          }
                          if (!value.isValidEmail()) {
                            return "Invalid email id";
                          }
                          return null;
                        },
                      ).px20(),
                      const Text(
                        'Password',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ).px20().pOnly(top: 20),
                      TextFormField(
                        controller: _password,
                        obscureText: _isObscure,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: 'Enter password provided by admin',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password cannot be empty";
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
                        onPressed: () async {
                          if (_registerationKey.currentState!.validate()) {
                            Map<String, dynamic> request = {
                              "rollNo": _rollNumber.text,
                              "mailId": _emailId.text,
                              "password": _password.text,
                            };
                            log(request.toString());
                            Repository repo = Repository();
                            CommonResponse response =
                                await repo.registerAndEnrollUser(request);

                            if (response.success == true) {
                              Alert(
                                context: context,
                                type: AlertType.success,
                                desc:
                                    "${response.message}. \n\n An email has been sent to your inbox with your password.",
                                buttons: [
                                  DialogButton(
                                    child: const Text(
                                      "Okay, Login now",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                      Navigator.pop(context);
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      );
                                    },
                                  )
                                ],
                              ).show();
                            } else {
                              Alert(
                                context: context,
                                type: AlertType.error,
                                desc: response.message ?? "Invalid Roll Number",
                                buttons: [
                                  DialogButton(
                                    child: const Text(
                                      "Okay",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                    width: 120,
                                  )
                                ],
                              ).show();
                            }
                          }
                        },
                        color: Colors.green,
                        child: const Text(
                          'Register',
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
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
