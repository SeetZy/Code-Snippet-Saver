/*
  * Utility imports
 */
import 'package:flutter/material.dart';
// ? https://pub.dev/packages/material_design_icons_flutter
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProgrammingIcons {
  static Widget icons(language) {
    // Switch statement to map file extension to appropriate icon
    switch (language) {
      case "py":
        return const Icon(
          MdiIcons.languagePython,
          size: 50,
        );
      case "rs":
        return const Icon(
          MdiIcons.languageRust,
          size: 50,
        );
      case "java":
        return const Icon(
          MdiIcons.languageJava,
          size: 50,
        );
      case "go":
        return const Icon(
          MdiIcons.languageGo,
          size: 50,
        );
      case "ruby":
        return const Icon(
          MdiIcons.languageRuby,
          size: 50,
        );
      case "js":
        return const Icon(
          MdiIcons.languageJavascript,
          size: 50,
        );
      case "ts":
        return const Icon(
          MdiIcons.languageTypescript,
          size: 50,
        );
      case "c":
        return const Icon(
          MdiIcons.languageC,
          size: 50,
        );
      case "cpp":
        return const Icon(
          MdiIcons.languageCpp,
          size: 50,
        );
      case "cs":
        return const Icon(
          MdiIcons.languageCsharp,
          size: 50,
        );
      case "php":
        return const Icon(
          MdiIcons.languagePhp,
          size: 50,
        );
      case "css":
        return const Icon(
          MdiIcons.languageCss3,
          size: 50,
        );
      case "html":
        return const Icon(
          MdiIcons.languageHtml5,
          size: 50,
        );
      case "json":
        return const Icon(
          MdiIcons.codeJson,
          size: 50,
        );
      default:
        return const Icon(
          MdiIcons.xml,
          size: 50,
        );
    }
  }
}
