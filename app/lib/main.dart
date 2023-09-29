/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/utils/app.routes.dart';
// ? https://pub.dev/packages/bitsdojo_window
import 'package:bitsdojo_window/bitsdojo_window.dart';
// ? https://pub.dev/packages/jwt_decoder
import 'package:jwt_decoder/jwt_decoder.dart';
// ? https://pub.dev/packages/shared_preferences
import 'package:shared_preferences/shared_preferences.dart';

/*
  * Page/Component imports
 */
import 'package:app/pages/signin.dart';
import 'package:app/pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Runs the app
  runApp(App(
    token: prefs.getString('token'),
  ));

  doWhenWindowReady(() {
    // Defines the minimum dekstop window size
    appWindow.minSize = const Size(1250, 650);
    // Defines the desktop window title
    appWindow.title = "Code Snippet Saver";
  });
}

class App extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final token;

  const App({@required this.token, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Defines all the routes
      routes: AppRoutes.routes,
      theme: ThemeData(
        colorScheme: const ColorScheme.dark(primary: Colors.grey),
      ),
      // Checks if there is a valid auth token saved since the last login
      home: Scaffold(
        body: (token == null)
            // If there isn't a authentification token
            ? const SignIn()
            : (JwtDecoder.isExpired(token) == false)
                // If there is then the user is sent to the home page
                ? Home(
                    token: token,
                  )
                // Else to the signin page
                : const SignIn(),
      ),
    );
  }
}
