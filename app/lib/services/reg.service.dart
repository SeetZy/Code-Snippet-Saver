/*
  * Utility imports
 */
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
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
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushNamed(AppRoutes.signinRoute);
          } else {
            log('something went wrong');
          }
        }
      }
    }
  }
}
