/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/providers/auth.notifier.dart';
import 'package:app/utils/global.vars.dart';
import 'package:app/utils/device.checker.dart';
import 'package:app/utils/app.routes.dart';
import 'package:provider/provider.dart';

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

  // Initializes the controllers
  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final AuthNotifier authNotifier = Provider.of<AuthNotifier>(
    //   context,
    //   listen: false,
    // );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthNotifier>(
          create: (_) => AuthNotifier(),
        )
      ],
      child: Scaffold(
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
                                    onPressed: () async {
                                      String email = _emailController.text;
                                      String password =
                                          _passwordController.text;

                                      if (email.isNotEmpty &&
                                          password.isNotEmpty) {
                                        await AuthNotifier.login(
                                            email: email, password: password);
                                        // ignore: use_build_context_synchronously
                                        Navigator.pushReplacementNamed(
                                            context, AppRoutes.homeRoute);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                "Please fill all the fields"),
                                          ),
                                        );
                                      }
                                    },
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
        ),
      ),
    );
  }
}