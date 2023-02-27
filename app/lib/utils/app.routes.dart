/*
  * Page route imports
 */
import 'package:app/pages/add.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/signin.dart';
import 'package:app/pages/signup.dart';
import 'package:app/pages/settings.dart';

class AppRoutes {
  static const String signinRoute = "/signin";
  static const String signupRoute = "/signup";
  static const String homeRoute = "/home";
  static const String addRoute = "/add";
  static const String settingsRoute = "/settings";

  static final routes = {
    signinRoute: (context) => const SignIn(),
    signupRoute: (context) => const SignUp(),
    homeRoute: (context) => const Home(),
    addRoute: (context) => const AddSnippet(),
    settingsRoute: (context) => const Settings(),
  };
}
