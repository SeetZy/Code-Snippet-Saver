/*
  * Utility imports
 */
import 'package:flutter/material.dart';

class Toast {
  static toastMsg(BuildContext context, msg, color) {
    // Use the ScaffoldMessenger to display a SnackBar (a small notification that appears at the bottom of the screen).
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: color,
        // Add an action button to the SnackBar that the user can tap to dismiss it.
        action: SnackBarAction(
          label: 'x',
          textColor: Colors.white,
          onPressed: () {},
        ),
      ),
    );
  }
}
