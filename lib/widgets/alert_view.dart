import 'package:flutter/material.dart';

class MyAlert extends StatelessWidget {
  const MyAlert({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // child: Alert(
        //   context: context,
        //   title: 'Alert Title',
        //   desc: 'This is an alert description.',
        //   buttons: [
        //     DialogButton(
        //       child: const Text(
        //         'CANCEL',
        //         style: TextStyle(color: Colors.white, fontSize: 20),
        //       ),
        //       onPressed: () => Navigator.pop(context),
        //       color: Colors.red,
        //     ),
        //     DialogButton(
        //       child: const Text(
        //         'OK',
        //         style: TextStyle(color: Colors.white, fontSize: 20),
        //       ),
        //       onPressed: () => Navigator.pop(context),
        //       color: Colors.green,
        //     ),
        //   ],
        // ),
        );
  }
}
