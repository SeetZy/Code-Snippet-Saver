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

class AuthService {
  static late SharedPreferences prefs;

  static initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  static signInUser(BuildContext context, email, password) async {
    if (email.isNotEmpty && password.isNotEmpty) {
      if (EmailValidator.validate(email) == true) {
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
          var token = jsonResponse['token'];
          prefs.setString('token', token);
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Home(
                token: token,
              ),
            ),
          );
        } else {
          log('something went wrong');
        }
      }
    }
  }
}
