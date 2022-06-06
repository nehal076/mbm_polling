import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbm_voting/common/shared.dart';
import 'package:mbm_voting/models/registration.dart';
import 'package:mbm_voting/screens/admin_home.dart';
import 'package:mbm_voting/screens/registration_screen.dart';
import 'package:mbm_voting/screens/user_home.dart';
import 'package:mbm_voting/services/repository.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _adminFormKey = GlobalKey<FormState>();
  final TextEditingController _emailId = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _adminPassword = TextEditingController();
  final TextEditingController _walletPassword = TextEditingController();
  int segmentedControlValue = 0;
  bool _isObscure = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        title: const Text('Studypods Blockchain'),
      ),
      body: Stack(
        children: [
          ListView(
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
                      'Login',
                      style: TextStyle(fontSize: 24),
                    ).p20(),
                    CupertinoSlidingSegmentedControl(
                      groupValue: segmentedControlValue,
                      onValueChanged: (value) {
                        setState(() {
                          segmentedControlValue = int.parse(value!.toString());
                        });
                      },
                      children: const <int, Widget>{
                        0: Text('User'),
                        1: Text('Admin'),
                      },
                    ),
                    segmentedControlValue == 0
                        ? Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Roll Number',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ).px20().pOnly(top: 20),
                                TextFormField(
                                  controller: _emailId,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelText: 'Enter your roll number',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Roll number cannot be empty";
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
                                  obscureText: !_isObscure,
                                  decoration: InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelText: 'Enter your password',
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
                                    return null;
                                  },
                                ).px20(),
                                const Text(
                                  'Wallet Password',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ).px20().pOnly(top: 20),
                                TextFormField(
                                  controller: _walletPassword,
                                  obscureText: !_isObscure,
                                  decoration: InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelText: 'Enter your wallet password',
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
                                      return "Wallet password cannot be empty";
                                    }
                                    return null;
                                  },
                                ).px20(),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RegistrationScreen(),
                                      ),
                                    );
                                  },
                                  child: const Center(
                                    child: Text(
                                      'New here? Register here',
                                      style: TextStyle(
                                        fontSize: 24,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ).py32(),
                                ),
                              ],
                            ),
                          )
                        : Form(
                            key: _adminFormKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Password',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ).px20().pOnly(top: 20),
                                TextFormField(
                                  controller: _adminPassword,
                                  obscureText: !_isObscure,
                                  decoration: InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    labelText: 'Enter your password',
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
                                    return null;
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
                              if (segmentedControlValue == 0) {
                                if (_formKey.currentState!.validate()) {
                                  _callUserLogin();
                                }
                              } else {
                                if (_adminFormKey.currentState!.validate()) {
                                  _callAdminLogin();
                                }
                              }
                            },
                            color: Colors.green,
                            child: const Text(
                              'Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
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
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container()
        ],
      ),
    );
  }

  _callUserLogin() async {
    Map<String, dynamic> request = {
      "rollNo": _emailId.text,
      "keyHash": _walletPassword.text,
      "password": _password.text,
    };

    log(request.toString());
    Repository repo = Repository();

    setState(() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    });

    CommonResponse response = await repo.loginUser(request);

    Navigator.pop(context);

    if (response.success == true) {
      MySharedPreferences.instance.setStringValue("rollNumber", _emailId.text);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const UserHome(),
        ),
      );
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

  _callAdminLogin() async {
    Map<String, dynamic> request = {
      "password": _adminPassword.text,
    };
    log(request.toString());
    Repository repo = Repository();

    setState(() {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      );
    });

    CommonResponse response = await repo.loginAdmin(request);

    setState(() {
      Navigator.pop(context);
    });

    if (response.success == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const AdminHome(),
        ),
      );
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
