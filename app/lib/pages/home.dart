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
import 'package:app/components/baseplate.dart';

class Home extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final token;
  const Home({super.key, @required this.token});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static late String userId;

  @override
  void initState() {
    super.initState();
    if (widget.token != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
      userId = jwtDecodedToken['_id'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Baseplate(
      title: 'Overview',
      child: Content(email: userId),
    );
  }
}

class Content extends StatelessWidget {
  const Content({Key? key, required this.email}) : super(key: key);

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
