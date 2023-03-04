// ignore_for_file: unnecessary_const

/*
  * Utility imports
 */
import 'dart:convert';
import 'dart:developer';
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
  static List? snippets;
  @override
  void initState() {
    super.initState();
    if (widget.token != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
      UserInfo.userId = jwtDecodedToken['_id'];
      UserInfo.email = jwtDecodedToken['email'];
    }
    getSnippets();
  }

  void getSnippets() async {
    try {
      var regBody = {
        "userId": UserInfo.userId,
      };

      var response = await http.post(
        Uri.parse(HttpRoutes.getUserSnippets),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      var jsonResponse = jsonDecode(response.body);
      snippets = jsonResponse['success'];

      setState(() {});
    } catch (error) {
      log('Error occurred during HTTP request: $error');
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
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  'Snippet Overview',
                  style: TextStyle(
                      fontSize: 25,
                      color: GlobalVariables.accentColor4,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: snippets == null
                    ? const SizedBox()
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: snippets!.length,
                        itemBuilder: (context, int index) {
                          return Card(
                            borderOnForeground: false,
                            child: ListTile(
                              leading: const Icon(Icons.task),
                              title: Text('${snippets![index]['fileName']}'),
                              subtitle: Text('${snippets![index]['desc']}'),
                            ),
                          );
                        },
                      ),
              ),
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
