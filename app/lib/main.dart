/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/utils/device.checker.dart';
import 'package:app/utils/global.vars.dart';
import 'package:app/utils/app.routes.dart';
// ? https://pub.dev/packages/bitsdojo_window
import 'package:bitsdojo_window/bitsdojo_window.dart';

void main() {
  runApp(App());

  //  Checks the device OS
  if (DeviceCheck().isDesktop) {
    // Desktop OS specific code
    doWhenWindowReady(() {
      // Defines the minimum dekstop window size
      appWindow.minSize = const Size(1200, 650);
      // Defines the desktop window title
      appWindow.title = "Code Snippet Saver";
    });
  }
}

// ignore: use_key_in_widget_constructors
class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Root();
  }
}

// ignore: use_key_in_widget_constructors
class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Sets the default application route
      initialRoute: AppRoutes.homeRoute,
      // Defines all the routes
      routes: AppRoutes.routes,
      theme: ThemeData(
        colorScheme:
            const ColorScheme.dark(primary: GlobalVariables.primaryColor),
      ),
    );
  }
}
