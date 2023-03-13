/*
  * Page route imports
 */
import 'package:app/pages/add.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/signin.dart';
import 'package:app/pages/signup.dart';
import 'package:app/pages/settings.dart';

// This file contains the routes for different pages in the app
class AppRoutes {
  // Constants are defined for each of the routes
  static const String signinRoute = "/signin";
  static const String signupRoute = "/signup";
  static const String homeRoute = "/home";
  static const String addRoute = "/add";
  static const String settingsRoute = "/settings";

  // A map is created which links each route to its corresponding page class
  static final routes = {
    signinRoute: (context) => const SignIn(),
    signupRoute: (context) => const SignUp(),
    homeRoute: (context) => const Home(
          token: null,
        ),
    addRoute: (context) => const AddSnippet(),
    settingsRoute: (context) => const Settings(),
  };
}
