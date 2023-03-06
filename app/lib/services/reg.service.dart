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
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text(
                      'User created successfully',
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
                      'A user with this email already exists',
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
                  'Your passwords do not container one or some of the following: atleast 1 number, capital letter or special character',
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
                'The passwords do not match',
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
}
