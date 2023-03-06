// ignore_for_file: use_build_context_synchronously

/*
  * Utility imports
 */
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';
import '../utils/http.routes.dart';
// ? https://pub.dev/packages/email_validator
import 'package:email_validator/email_validator.dart';
// ? https://pub.dev/packages/http
import 'package:http/http.dart' as http;
// ? https://pub.dev/packages/shared_preferences
import 'package:shared_preferences/shared_preferences.dart';

class UserSettings {
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
        // Clear the token from storage
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
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

  // Function to update user data
  static void updateUserData(BuildContext context, id, username, email) async {
    // Checks if the text fields are filled
    if (username.isNotEmpty && email.isNotEmpty) {
      // Checks if the provided email is valid
      if (EmailValidator.validate(email) == true) {
        try {
          // Show loading bar
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const Center(child: CircularProgressIndicator());
            },
          );

          var regBody = jsonEncode({"username": username, "email": email});

          var response = await http.put(
            Uri.parse('${HttpRoutes.updateUserData}/$id'),
            headers: {"Content-Type": "application/json"},
            body: regBody,
          );

          var jsonResponse = jsonDecode(response.body);

          if (jsonResponse['status']) {
            // Closes the loading bar
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Successfully updated user settings',
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Please enter a vdalid email',
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
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please fill all the fields',
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
  }
}
