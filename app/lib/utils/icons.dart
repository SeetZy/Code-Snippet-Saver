/*
  * Utility imports
 */
import 'package:flutter/material.dart';
// ? https://pub.dev/packages/material_design_icons_flutter
// ? https://pictogrammers.com/library/mdi/
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProgrammingIcons {
  // Defines the list of available programming languages in the dropdown menu
  static final List<String> progLang = [
    'py',
    'rs',
    'java',
    'go',
    'ruby',
    'js',
    'ts',
    'c',
    'cpp',
    'cs',
    'php',
    'f',
    'hs',
    'kt',
    'swift',
    'R',
    'css',
    'html',
    'json',
    'other'
  ];

  static Widget icons(language) {
    // Switch statement to map file extension to appropriate icon
    switch (language) {
      case "py":
        return const Icon(
          MdiIcons.languagePython,
          size: 50,
          color: Colors.white,
        );
      case "rs":
        return const Icon(
          MdiIcons.languageRust,
          size: 50,
          color: Colors.white,
        );
      case "java":
        return const Icon(
          MdiIcons.languageJava,
          size: 50,
          color: Colors.white,
        );
      case "go":
        return const Icon(
          MdiIcons.languageGo,
          size: 50,
          color: Colors.white,
        );
      case "ruby":
        return const Icon(
          MdiIcons.languageRuby,
          size: 50,
          color: Colors.white,
        );
      case "js":
        return const Icon(
          MdiIcons.languageJavascript,
          size: 50,
          color: Colors.white,
        );
      case "ts":
        return const Icon(
          MdiIcons.languageTypescript,
          size: 50,
          color: Colors.white,
        );
      case "c":
        return const Icon(
          MdiIcons.languageC,
          size: 50,
          color: Colors.white,
        );
      case "cpp":
        return const Icon(
          MdiIcons.languageCpp,
          size: 50,
          color: Colors.white,
        );
      case "cs":
        return const Icon(
          MdiIcons.languageCsharp,
          size: 50,
          color: Colors.white,
        );
      case "php":
        return const Icon(
          MdiIcons.languagePhp,
          size: 50,
          color: Colors.white,
        );
      case "f":
        return const Icon(
          MdiIcons.languageFortran,
          size: 50,
          color: Colors.white,
        );
      case "hs":
        return const Icon(
          MdiIcons.languageHaskell,
          size: 50,
          color: Colors.white,
        );
      case "kt":
        return const Icon(
          MdiIcons.languageKotlin,
          size: 50,
          color: Colors.white,
        );
      case "swift":
        return const Icon(
          MdiIcons.languageSwift,
          size: 50,
          color: Colors.white,
        );
      case "R":
        return const Icon(
          MdiIcons.languageR,
          size: 50,
          color: Colors.white,
        );
      case "css":
        return const Icon(
          MdiIcons.languageCss3,
          size: 50,
          color: Colors.white,
        );
      case "html":
        return const Icon(
          MdiIcons.languageHtml5,
          size: 50,
          color: Colors.white,
        );
      case "json":
        return const Icon(
          MdiIcons.codeJson,
          size: 50,
          color: Colors.white,
        );
      default:
        return const Icon(
          MdiIcons.xml,
          size: 50,
          color: Colors.white,
        );
    }
  }
}
