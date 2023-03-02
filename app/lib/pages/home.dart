/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/utils/app.routes.dart';
import '../services/user.info.dart';
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
  @override
  void initState() {
    super.initState();
    if (widget.token != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
      UserInfo.userId = jwtDecodedToken['_id'];
      UserInfo.email = jwtDecodedToken['email'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Baseplate(
      title: 'Overview',
      child: Content(),
    );
  }
}

class Content extends StatelessWidget {
  const Content({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Text(
            "Welcome ${UserInfo.userId}",
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
