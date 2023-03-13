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
import '../pages/home.dart';
import 'package:app/components/toasts.dart';

// A class for managing user authentification
class AuthService {
  // Declares a static variable to hold shared preferences
  static late SharedPreferences prefs;

  // Initialize shared preferences
  static initSharedPrefs() async {
    // Get an instance of shared preferences
    prefs = await SharedPreferences.getInstance();
  }

  static signInUser(BuildContext context, email, password) async {
    // Checks if the text fields are filled
    if (email.isNotEmpty && password.isNotEmpty) {
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

          var regBody = {
            "email": email,
            "password": password,
          };

          var response = await http.post(
            Uri.parse(HttpRoutes.signInUrl),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(regBody),
          );

          var jsonResponse = jsonDecode(response.body);

          if (jsonResponse['status']) {
            // Closes the loading bar
            Navigator.of(context).pop();
            var token = jsonResponse['token'];
            prefs.setString('token', token);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Home(
                  token: token,
                ),
              ),
            );

            Toast.toastMsg(context, 'User has signed in successfully',
                GlobalVariables.accentColor2);
          } else {
            // Closes the loading bar
            Navigator.of(context).pop();

            Toast.toastMsg(context, 'Please check the email and password',
                GlobalVariables.accentColor3);
          }
        } catch (error) {
          log('Error occurred during HTTP request: $error');
        }
      } else {
        Toast.toastMsg(context, 'Please provide a valid email adress',
            GlobalVariables.accentColor3);
      }
    } else {
      Toast.toastMsg(
          context, 'Please fill all the fields', GlobalVariables.accentColor3);
    }
  }
}
