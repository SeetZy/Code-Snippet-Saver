/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/services/user.info.dart';
import 'package:app/utils/app.routes.dart';
// ? https://pub.dev/packages/jwt_decoder
import 'package:jwt_decoder/jwt_decoder.dart';

/*
  * Page/Component imports
 */
import 'package:app/components/baseplate.dart';
import 'package:app/components/show.snippets.dart';

class Home extends StatefulWidget {
  // The 'token' variable is passed in from the previous page to verify user authentification
  // ignore: prefer_typing_uninitialized_variables
  final token;
  const Home({Key? key, required this.token}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // If a token was passed in, decode the token to extract the user information and store it in the UserInfo class
    if (widget.token != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
      UserInfo.userId = jwtDecodedToken['_id'];
      UserInfo.username = jwtDecodedToken['username'];
      UserInfo.email = jwtDecodedToken['email'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Baseplate(
      child: Stack(
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  'Snippet Overview',
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              // Displays all of the saved snippets
              ShowSnippets(),
            ],
          ),

          // Button to add new snippets
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.addRoute);
              },
              label: const Text(
                "Add\nSnippet",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
