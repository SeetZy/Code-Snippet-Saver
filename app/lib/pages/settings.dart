/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';
// ? https://pub.dev/packages/jwt_decoder
import 'package:jwt_decoder/jwt_decoder.dart';

/*
  * Page/Component imports
 */
import 'package:app/components/baseplate.dart';

class Settings extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final token;
  const Settings({super.key, @required this.token});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  static late String email;
  @override
  void initState() {
    super.initState();
    if (widget.token != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
      email = jwtDecodedToken['email'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Baseplate(
      title: 'Overview',
      child: Content(email: email),
    );
  }
}

class Content extends StatelessWidget {
  const Content({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Settings of $email",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            )
          ],
        ),

        // Button to add new snippets
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton.extended(
            backgroundColor: GlobalVariables.accentColor3,
            elevation: 0,
            onPressed: () {},
            label: const Text(
              "Logout",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
