/*
  * Utility imports
 */
import 'package:flutter/material.dart';
// ? https://pub.dev/packages/font_awesome_flutter
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProgrammingIcons {
  static Widget icons(language) {
    switch (language) {
      case "py":
        return const FaIcon(
          FontAwesomeIcons.python,
          size: 50,
        );
      case "js":
        return const FaIcon(
          FontAwesomeIcons.js,
          size: 50,
        );
      case "php":
        return const FaIcon(
          FontAwesomeIcons.php,
          size: 50,
        );
      case "css":
        return const FaIcon(
          FontAwesomeIcons.css3,
          size: 50,
        );
      case "html":
        return const FaIcon(
          FontAwesomeIcons.html5,
          size: 50,
        );
      default:
        return const FaIcon(
          FontAwesomeIcons.code,
          size: 50,
        );
    }
  }
}
