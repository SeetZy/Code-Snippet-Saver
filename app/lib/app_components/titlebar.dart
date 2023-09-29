/*
  * Util/dependency imports
 */
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';
// ? https://pub.dev/packages/bitsdojo_window/install
import 'package:bitsdojo_window/bitsdojo_window.dart';

class TitleBar extends StatefulWidget {
  const TitleBar({super.key});

  @override
  State<TitleBar> createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> {
  @override
  Widget build(BuildContext context) {
    // Return a Container widget with a background color and a child Column widget
    return Container(
      color: GlobalVariables.primaryColor,
      // Add the WindowTitleBarBox widget, which contains the title of the app and the window buttons
      child: WindowTitleBarBox(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Make the window title bar movable using the MoveWindow widget
            Expanded(
              child: MoveWindow(
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0, top: 5),
                  // Set the title of the app in the window title bar
                  child: Text(
                    "Code Snippet Saver",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),

            // Add the WindowButtons widget to display the custom window buttons
            const WindowButtons()
          ],
        ),
      ),
    );
  }
}

// Define the WindowButtons widget
class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    // Return a Row widget that contains the custom window buttons
    return Row(
      children: [
        // Add the MinimizeWindowButton widget
        MinimizeWindowButton(),
        // Add the MaximizeWindowButton widget
        MaximizeWindowButton(),
        // Add the CloseWindowButton widget
        CloseWindowButton(),
      ],
    );
  }
}
