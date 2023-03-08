// ignore_for_file: use_build_context_synchronously

/*
  * Utility imports
 */
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';
import 'package:app/utils/http.routes.dart';
import 'package:app/utils/app.routes.dart';
// ? https://pub.dev/packages/email_validator
import 'package:email_validator/email_validator.dart';
// ? https://pub.dev/packages/http
import 'package:http/http.dart' as http;

/*
  * Page/Component imports
 */
import 'package:app/components/toasts.dart';

class RegService {
  static RegExp upperCase = RegExp(r'[A-Z]');
  static RegExp digit = RegExp(r'[0-9]');
  static RegExp specialChar =
      RegExp(r'[!@#\$%\^&\*\(\)_\+{}\|:<>\?\-=\[\]\\;\,./]');

  static Future<void> signUpUser(
      BuildContext context, username, email, password, confirmPassword) async {
    bool hasUpperCase = upperCase.hasMatch(password);
    bool hasDigit = digit.hasMatch(password);
    bool hasSpecialChar = specialChar.hasMatch(password);

    // Checks if the text fields are filled
    if (username.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty) {
      // Checks if the provided email is valid
      if (EmailValidator.validate(email) == true) {
        // Checks if the provided passwords are the same
        if (password == confirmPassword) {
          // Checks if the provided passwords contain atleast 1 capital letter, special character, number
          if (hasUpperCase &&
              hasDigit &&
              hasSpecialChar &&
              password.length >= 8) {
            try {
              // Show loading bar
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const Center(child: CircularProgressIndicator());
                },
              );

              var regBody = {
                "username": username,
                "email": email,
                "password": password,
              };

              var response = await http.post(
                Uri.parse(HttpRoutes.signUpUrl),
                headers: {"Content-Type": "application/json"},
                body: jsonEncode(regBody),
              );

              var jsonResponse = jsonDecode(response.body);

              if (jsonResponse['status']) {
                // Closes the loading bar
                Navigator.of(context).pop();

                Navigator.of(context).pushNamed(AppRoutes.signinRoute);

                Toast.toastMsg(context, 'User created successfully',
                    GlobalVariables.accentColor2);
              } else {
                // Closes the loading bar
                Navigator.of(context).pop();

                Toast.toastMsg(
                    context,
                    'A user with this email adress already exists',
                    GlobalVariables.accentColor3);
              }
            } catch (error) {
              log('Error occurred duting HTTP request: $error');
            }
          } else {
            Toast.toastMsg(
                context,
                'Your passwords do not container one or some of the following: atleast 1 number, capital letter or special character',
                GlobalVariables.accentColor3);
          }
        } else {
          Toast.toastMsg(context, 'The password do not match',
              GlobalVariables.accentColor3);
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
