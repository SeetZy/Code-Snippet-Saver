// ignore_for_file: use_build_context_synchronously

/*
  * Utility imports
 */
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:app/utils/http.routes.dart';
// ? https://pub.dev/packages/email_validator
import 'package:email_validator/email_validator.dart';
// ? https://pub.dev/packages/http
import 'package:http/http.dart' as http;
// ? https://pub.dev/packages/shared_preferences
import 'package:shared_preferences/shared_preferences.dart';

/*
  * Page/component imports
 */
import '../pages/home.dart';
import '../utils/global.vars.dart';

class AuthService {
  static late SharedPreferences prefs;

  static initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  static signInUser(BuildContext context, email, password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
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
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'User has signed in successfully',
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
            // Closes the loading bar
            Navigator.of(context).pop();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text(
                  'Please check the email and password',
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
          log('Error occurred during HTTP request: $error');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Please provide a valid email',
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

  static logout(BuildContext context) async {
    // Clear the token from storage
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');

    // Navigate to the login screen
    Navigator.pushReplacementNamed(context, '/signin');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Successfully signed out',
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
  }
}
