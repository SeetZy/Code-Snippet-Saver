/*
  * Utility imports
 */
import 'package:app/services/auth.service.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';
import 'package:app/utils/app.routes.dart';

/*
  * Page/component imports
 */
import 'package:app/app_components/titlebar.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    AuthService.initSharedPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const TitleBar(),
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
                                    // Get the controller input as text
                                    final String email = _emailController.text;
                                    final String password =
                                        _passwordController.text;

                                    AuthService.signInUser(
                                        context, email, password);
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
