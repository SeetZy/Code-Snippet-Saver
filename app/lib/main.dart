/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/db/db.dart';
import 'package:app/utils/device.checker.dart';
import 'package:app/utils/global.vars.dart';
import 'package:app/utils/app.routes.dart';
// ? https://pub.dev/packages/bitsdojo_window
import 'package:bitsdojo_window/bitsdojo_window.dart';
// ? https://pub.dev/packages/supabase_flutter
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  // Initializes the database
  await Supabase.initialize(
    url: SupabaseConstants.projURL,
    anonKey: SupabaseConstants.apiKEY,
  );

  // Runs the app
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Sets the default application route
      initialRoute: AppRoutes.loginRoute,
      // Defines all the routes
      routes: AppRoutes.routes,
      theme: ThemeData(
        colorScheme:
            const ColorScheme.dark(primary: GlobalVariables.primaryColor),
      ),
    );
  }
}
