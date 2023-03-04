/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/utils/app.routes.dart';
import 'package:app/utils/global.vars.dart';
// ? https://pub.dev/packages/shared_preferences
import 'package:shared_preferences/shared_preferences.dart';
// ? https://pub.dev/packages/bitsdojo_window
import 'package:bitsdojo_window/bitsdojo_window.dart';
// ? https://pub.dev/packages/jwt_decoder
import 'package:jwt_decoder/jwt_decoder.dart';

/*
  * Page/Component imports
 */
import 'package:app/pages/signin.dart';
import 'package:app/pages/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(App(
    token: prefs.getString('token') ?? "",
  ));

  doWhenWindowReady(() {
    appWindow.minSize = const Size(1250, 650);
    appWindow.title = "Code Snippet Saver";
  });
}

class App extends StatelessWidget {
  final String token;

  const App({required this.token, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Defines all the routes
      routes: AppRoutes.routes,
      theme: ThemeData(
        colorScheme:
            const ColorScheme.dark(primary: GlobalVariables.accentColor),
      ),
      // Checks if there is a valid auth token saved since the last login
      home: Scaffold(
        body: (token.isEmpty)
            ?
            // If token is null or empty, show the sign in screen
            const SignIn()
            : (JwtDecoder.isExpired(token) == false)
                ?
                // If the token is not expired, show the home screen
                Home(token: token)
                :
                // If the token is expired, show the sign in screen
                const SignIn(),
      ),
    );
  }
}
