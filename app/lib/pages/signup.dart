/*
  * Utility imports
 */
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';
import 'package:app/utils/device.checker.dart';
import 'package:app/utils/app.routes.dart';
import 'package:app/utils/http.routes.dart';
// ? https://pub.dev/packages/email_validator
import 'package:email_validator/email_validator.dart';
// ? https://pub.dev/packages/http
import 'package:http/http.dart' as http;

/*
  * Page/component imports
 */
import '../app_components/titlebar.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  void signUpUser() async {
    // Checks if the text fields are filled
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty) {
      // Checks if the provided email is valid
      if (EmailValidator.validate(_emailController.text) == true) {
        // Checks if the provided passwords are valid
        // ignore: unrelated_type_equality_checks
        if (_passwordController.text == _confirmPasswordController.text) {
          var regBody = {
            "email": _emailController.text,
            "password": _passwordController.text,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Uses the titlebar widget
            Visibility(
              visible: DeviceCheck().isDesktop,
              child: const TitleBar(),
            ),
            Expanded(
              child: Container(
                // Container style
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Center(
                  child: Container(
                    // Container style
                    decoration: const BoxDecoration(
                      color: GlobalVariables.primaryColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    width: 300,
                    height: 500,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        // Makes the column take up all the remaining space
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(40),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // Email text input field
                          TextField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              hintText: "Email",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          // Password text input field
                          TextField(
                            obscureText: true,
                            controller: _passwordController,
                            decoration: const InputDecoration(
                              hintText: "Password",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          // Password text input field
                          TextField(
                            obscureText: true,
                            controller: _confirmPasswordController,
                            decoration: const InputDecoration(
                              hintText: "Password",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          // Buttons for SignUp and redirecting to login page
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    signUpUser();
                                  },
                                  child: const Text("Sign Up"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRoutes.signinRoute);
                                  },
                                  child: const Text(
                                    "Already a member? Click here to sign in",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
