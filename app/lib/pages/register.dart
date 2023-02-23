/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';
import 'package:app/utils/device.checker.dart';
import 'package:app/utils/app.routes.dart';

/*
  * Page/component imports
 */
import '../app_components/titlebar.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Controllers
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                      color: GlobalVariables.secondaryColor,
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

                          // Buttons for Register and redirecting to login page
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    String email = _emailController.text;
                                    String password = _passwordController.text;
                                  },
                                  child: const Text("Sign Up"),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(AppRoutes.loginRoute);
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
