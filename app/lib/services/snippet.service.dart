/*
  * Utility imports
 */
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:app/services/user.info.dart';
import '../utils/http.routes.dart';
// ? https://pub.dev/packages/http
import 'package:http/http.dart' as http;

class SnippetService {
  // Checks if the code snippet data is empty or not
  static saveCodeSnippet(
      BuildContext context, fileName, fileType, snippet, description) async {
    if (fileName.isNotEmpty &&
        fileType.isNotEmpty &&
        snippet.isNotEmpty &&
        description.isNotEmpty) {
      try {
        var regBody = {
          "userId": UserInfo.userId,
          "fileName": fileName,
          "fileType": fileType,
          "snippet": snippet,
          "description": description
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
      } catch (error) {
        log('Error occurred duting HTTP request: $error');
      }
    }
  }
}
