/*
  * Utility imports
 */
import 'package:flutter/material.dart';

// Create a class named 'Toast' to hold static method(s) that can be called from anywhere in the app.
class Toast {
  // Define a static method named 'toastMsg' that takes three arguments: a BuildContext object, a message, and a color.
  static toastMsg(BuildContext context, msg, color) {
    // Use the ScaffoldMessenger to display a SnackBar (a small notification that appears at the bottom of the screen).
    ScaffoldMessenger.of(context).showSnackBar(
      // Create a new SnackBar widget with the message and background color specified by the caller.
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
