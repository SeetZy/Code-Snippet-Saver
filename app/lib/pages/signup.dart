/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/services/reg.service.dart';
import 'package:app/utils/global.vars.dart';
import 'package:app/utils/app.routes.dart';
// ? https://pub.dev/packages/animate_gradient
import 'package:animate_gradient/animate_gradient.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimateGradient(
        primaryBegin: Alignment.topLeft,
        primaryEnd: Alignment.bottomLeft,
        secondaryBegin: Alignment.bottomLeft,
        secondaryEnd: Alignment.topRight,
        primaryColors: const [
          Colors.pink,
          Colors.pinkAccent,
          Colors.white,
        ],
        secondaryColors: const [
          Colors.white,
          Colors.blueAccent,
          Colors.blue,
        ],
        child: Column(
          children: [
            const TitleBar(),
            Expanded(
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

                        // Confirm password text input field
                        TextField(
                          obscureText: true,
                          controller: _confirmPasswordController,
                          decoration: const InputDecoration(
                            hintText: "Confirm Password",
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
                                  // Get the controller input as text
                                  final String email = _emailController.text;
                                  final String password =
                                      _passwordController.text;
                                  final String confirmPassword =
                                      _confirmPasswordController.text;

                                  RegService.signUpUser(context, email,
                                      password, confirmPassword);
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
          ],
        ),
      ),
    );
  }
}
