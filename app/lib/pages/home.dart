/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/services/user.info.dart';
import 'package:app/utils/global.vars.dart';
import 'package:app/utils/app.routes.dart';
// ? https://pub.dev/packages/jwt_decoder
import 'package:jwt_decoder/jwt_decoder.dart';

/*
  * Page/Component imports
 */
import 'package:app/components/baseplate.dart';
import 'package:app/components/show.snippets.dart';

class Home extends StatefulWidget {
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
      title: 'Overview',
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Padding(
                padding: EdgeInsets.only(left: 10, right: 20, bottom: 10),
                child: Text(
                  'Snippet Overview',
                  style: TextStyle(
                      fontSize: 25,
                      color: GlobalVariables.accentColor4,
                      fontWeight: FontWeight.w600),
                ),
              ),
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
                style: TextStyle(color: Colors.white),
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
