/*
  * Utility imports
 */
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import '../utils/http.routes.dart';
import '../services/user.info.dart';
// ? https://pub.dev/packages/http
import 'package:http/http.dart' as http;

class SaveCodeSnippet {
  // Checks if the code snippet data is empty or not
  static saveCodeSnippet(
      BuildContext context, fileName, fileType, snippet) async {
    if (fileName.isNotEmpty && fileType.isNotEmpty && snippet.isNotEmpty) {
      var regBody = {
        "userId": UserInfo.userId,
        "fileName": fileName,
        "fileType": fileType,
        "snippet": snippet,
      };

      var response = await http.post(
        Uri.parse(HttpRoutes.addSnippetUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status']) {
        log('Added the code snippet');
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      } else {
        log('something went wrong');
      }
    }
  }
}
