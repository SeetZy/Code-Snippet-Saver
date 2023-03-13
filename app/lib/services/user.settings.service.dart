// ignore_for_file: use_build_context_synchronously

/*
  * Utility imports
 */
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';
import 'package:app/utils/http.routes.dart';
// ? https://pub.dev/packages/email_validator
import 'package:email_validator/email_validator.dart';
// ? https://pub.dev/packages/http
import 'package:http/http.dart' as http;
// ? https://pub.dev/packages/shared_preferences
import 'package:shared_preferences/shared_preferences.dart';

/*
  * Page/Component imports
 */
import 'package:app/components/toasts.dart';

// A class for managing user settings
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

      // HTTP DELETE request
      var response = await http.delete(
        Uri.parse(HttpRoutes.deleteUser),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        // Closes the loading bar
        Navigator.of(context).pop();

        Toast.toastMsg(context, 'Profile successfully deleted',
            GlobalVariables.accentColor2);

        // Clear the token from storage
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
        // Navigate to the registration screen
        Navigator.pushReplacementNamed(context, '/signup');
      } else {
        Toast.toastMsg(context, 'Something went wrong. Please try againg',
            GlobalVariables.accentColor3);
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

          // HTTP PUT request
          var response = await http.put(
            Uri.parse('${HttpRoutes.updateUserData}/$id'),
            headers: {"Content-Type": "application/json"},
            body: regBody,
          );

          var jsonResponse = jsonDecode(response.body);

          if (jsonResponse['status']) {
            // Closes the loading bar
            Navigator.of(context).pop();

            Toast.toastMsg(context, 'Successfully updated user settings',
                GlobalVariables.accentColor2);
          } else {
            Toast.toastMsg(context, 'Something went wrong. Please try again',
                GlobalVariables.accentColor3);
          }
        } catch (error) {
          log('Error occurred duting HTTP request: $error');
        }
      } else {
        Toast.toastMsg(context, 'Please enter a valid email adress',
            GlobalVariables.accentColor3);
      }
    } else {
      Toast.toastMsg(
          context, 'Please fill all the fields', GlobalVariables.accentColor3);
    }
  }

  // Function to logout the user
  static logout(BuildContext context) async {
    // Clear the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');

    // Navigate to the login screen
    Navigator.pushReplacementNamed(context, '/signin');

    Toast.toastMsg(
        context, 'Successfully signed out', GlobalVariables.accentColor2);
  }
}
