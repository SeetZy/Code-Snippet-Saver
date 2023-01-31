/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';
import 'package:app/utils/app.routes.dart';

/*
  * Page/component imports
 */
import 'package:app/app_components/titlebar.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Controllers
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Uses the titlebar widget
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
                    color: GlobalVariables.secondaryColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                  width: 300,
                  height: 400,
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
                            "Login",
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

                        // Buttons for login and redirecting to register page
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                child: const Text("Login"),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(AppRoutes.registerRoute);
                                },
                                child: const Text(
                                  "Not a member? Click here to register",
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
    );
  }
}
