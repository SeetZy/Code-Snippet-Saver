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
// ? https://pub.dev/packages/shared_preferences
import 'package:shared_preferences/shared_preferences.dart';

/*
  * Page/component imports
 */
import 'package:app/app_components/titlebar.dart';
import 'package:app/pages/home.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPrefs();
  }

  void initSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  void signInUser() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty) {
      if (EmailValidator.validate(_emailController.text) == true) {
        var regBody = {
          "email": _emailController.text,
          "password": _passwordController.text,
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
                      )));
        } else {
          log('something went wrong');
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
                    height: 450,
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
                              "Sign In",
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

                          // Buttons for to sign in the user
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    signInUser();
                                  },
                                  child: const Text("Sign In"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // Button to redirect to the sign up page
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRoutes.signupRoute);
                                  },
                                  child: const Text(
                                    "Not a member? Click here to sign up",
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
