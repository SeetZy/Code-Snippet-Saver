/*
  * Page route imports
 */
import 'package:app/pages/add.dart';
import 'package:app/pages/home.dart';
import 'package:app/pages/login.dart';
import 'package:app/pages/register.dart';
import 'package:app/pages/settings.dart';

class AppRoutes {
  static const String loginRoute = "/login";
  static const String registerRoute = "/register";
  static const String homeRoute = "/home";
  static const String addRoute = "/add";
  static const String settingsRoute = "/settings";

  static final routes = {
    loginRoute: (context) => const Login(),
    registerRoute: (context) => const Register(),
    homeRoute: (context) => const Home(),
    addRoute: (context) => const AddSnippet(),
    settingsRoute: (context) => const Settings(),
  };
}
