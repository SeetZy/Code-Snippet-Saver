// ignore_for_file: unnecessary_const

/*
  * Utility imports
 */
import 'dart:convert';
import 'dart:developer';
import 'package:app/components/show.snippets.dart';
import 'package:flutter/material.dart';
import '../services/user.info.dart';
import '../utils/global.vars.dart';
import '../utils/http.routes.dart';
import 'package:app/utils/app.routes.dart';
// ? https://pub.dev/packages/jwt_decoder
import 'package:jwt_decoder/jwt_decoder.dart';
// ? https://pub.dev/packages/http
import 'package:http/http.dart' as http;

/*
  * Page/Component imports
 */
import 'package:app/components/baseplate.dart';

class Home extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final token;
  const Home({super.key, @required this.token});

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
      UserInfo.email = jwtDecodedToken['email'];
      getSnippets(UserInfo.userId);
    }
  }

  void getSnippets(userId) async {
    try {
      var response = await http.get(
          Uri.parse('${HttpRoutes.getUserSnippets}?userId=${UserInfo.userId}'),
          headers: {"Content-Type": "application/json"});

      var jsonResponse = jsonDecode(response.body);

      UserInfo.snippets = jsonResponse['success'];
      setState(() {});
    } catch (error) {
      log('An error occurred whilst doing a HTTP request: $error');
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
                padding: EdgeInsets.only(bottom: 10),
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
