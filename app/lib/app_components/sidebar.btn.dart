/*
  * Utility imports
 */
import 'package:app/utils/global.vars.dart';
import 'package:flutter/material.dart';
// ? https://pub.dev/packages/just_the_tooltip
import 'package:just_the_tooltip/just_the_tooltip.dart';

class SidebarButton extends StatefulWidget {
  const SidebarButton(
      {super.key,
      required this.title,
      required this.tooltip,
      required this.icon,
      required this.route});

  @override
  State<SidebarButton> createState() => _SidebarButtonState();
  // Define the required variables for the SidebarButton widget
  final String title;
  final String tooltip;
  final IconData icon;
  final String route;
}

class _SidebarButtonState extends State<SidebarButton> {
  @override
  Widget build(BuildContext context) {
    return JustTheTooltip(
      preferredDirection: AxisDirection.down,
      tailLength: 7,
      backgroundColor: GlobalVariables.primaryColor2,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(widget.tooltip),
      ),
      child: SizedBox(
        width: 200,
        child: IconButton(
          onPressed: () {
            // Navigate to the selected route when the button is clicked
            Navigator.of(context).pushNamed(widget.route);
          },
          icon: Icon(
            widget.icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
