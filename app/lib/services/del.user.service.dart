// ignore_for_file: use_build_context_synchronously

/*
  * Utility imports
 */
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';
import '../utils/http.routes.dart';
// ? https://pub.dev/packages/http
import 'package:http/http.dart' as http;

class DelUser {
  // Function to delete a snippet
  static void deleteUser(BuildContext context, id) async {
    try {
      // Show loading bar
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      var regBody = {"id": id};

      var response = await http.post(
        Uri.parse(HttpRoutes.deleteUser),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        // Closes the loading bar
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Profile successfully deleted',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: GlobalVariables.accentColor2,
            action: SnackBarAction(
              label: 'x',
              textColor: Colors.white,
              onPressed: () {
                // code to be executed when the user dismisses the SnackBar
              },
            ),
          ),
        );
        // Navigate to the login screen
        Navigator.pushReplacementNamed(context, '/signin');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: GlobalVariables.accentColor3,
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
    } catch (error) {
      log('Error occurred duting HTTP request: $error');
    }
  }
}
