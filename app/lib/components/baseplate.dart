/*
  * Utility imports
 */
import 'package:flutter/material.dart';

/*
  * Page/component imports
 */
import 'package:app/app_components/sidebar.dart';
import 'package:app/app_components/titlebar.dart';

class Baseplate extends StatelessWidget {
  // Define a constructor for Baseplate which takes a key, child and title.
  const Baseplate({super.key, required this.child});

  // The child widget to display in the body of the scaffold.
  final Widget child;

  // Define the build method for Baseplate, which builds the UI of the screen.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Add the TitleBar component to the top of the screen.
          const TitleBar(),
          // Add a row to contain the Sidebar and the main content of the screen.
          Row(
            children: [
              // Add the Sidebar component to the left side of the screen.
              const SideBar(),
              // Add an expanded container to the right side of the screen to contain the child widget.
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height - 32,
                  color: Colors.white,
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
