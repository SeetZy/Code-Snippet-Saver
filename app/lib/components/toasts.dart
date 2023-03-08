import 'package:flutter/material.dart';

class Toast {
  static toastMsg(BuildContext context, msg, color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: color,
        action: SnackBarAction(
          label: 'x',
          textColor: Colors.white,
          onPressed: () {
            // code to be executed when the user dismisses the SnackBar
          },
        ),
      ),
    );
  }
}
