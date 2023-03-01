/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/utils/app.routes.dart';
// ? https://pub.dev/packages/jwt_decoder
import 'package:jwt_decoder/jwt_decoder.dart';

/*
  * Page/Component imports
 */
import 'package:app/components/template.dart';

class Home extends StatefulWidget {
  final token;
  const Home({super.key, @required this.token});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static late String email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);

    email = jwtDecodedToken['email'];
  }

  @override
  Widget build(BuildContext context) {
    return Template(
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
        Center(
          child: Text(
            "Welcome $email",
          ),
        ),

        // Button to add new snippets
        Positioned(
          right: 16,
          bottom: 16,
          child: FloatingActionButton.extended(
            elevation: 0,
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
    );
  }
}
