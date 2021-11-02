import 'dart:async';

import 'package:flutter/material.dart';

class LoaderDialog {
  static final dialogContextCompleter = Completer<BuildContext>();
  static Future<void> showLoadingDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (dialogContext) {
        if (!dialogContextCompleter.isCompleted) {
          dialogContextCompleter.complete(dialogContext);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  static closeLoadingDialog() async {
    final dialogContext = await dialogContextCompleter.future;
    Navigator.pop(dialogContext);
  }
}
