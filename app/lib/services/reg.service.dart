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
  static signUpUser(
      BuildContext context, email, password, confirmPassword) async {
    // Checks if the text fields are filled
    if (email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
      // Checks if the provided email is valid
      if (EmailValidator.validate(email) == true) {
        // Checks if the provided passwords are valid
        // ignore: unrelated_type_equality_checks
        if (password == confirmPassword) {
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
