/*
  * Utility imports
 */
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';
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
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Successfully added a code snippet',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: GlobalVariables.accentColor2,
              action: SnackBarAction(
                label: 'x',
                textColor: Colors.white,
                onPressed: () {
                  // code to be executed when the user dismisses the SnackBar
                },
              ),
            ),
          );
        } else {
          // ignore: use_build_context_synchronously
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'Something went wrong',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: GlobalVariables.accentColor3,
              action: SnackBarAction(
                label: 'x',
                textColor: Colors.white,
                onPressed: () {
                  // code to be executed when the user dismisses the SnackBar
                },
              ),
            ),
          );
        }
      } catch (error) {
        log('Error occurred duting HTTP request: $error');
      }
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Please fill all the fields',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: GlobalVariables.accentColor3,
          action: SnackBarAction(
            label: 'x',
            textColor: Colors.white,
            onPressed: () {
              // code to be executed when the user dismisses the SnackBar
            },
          ),
        ),
      );
    }
  }

  // Function to delete a snippet
  static void deleteSnippet(BuildContext context, id) async {
    try {
      var regBody = {"id": id};

      var response = await http.post(
        Uri.parse(HttpRoutes.deleteSnippets),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Successfully Deleted a code snippet',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: GlobalVariables.accentColor2,
            action: SnackBarAction(
              label: 'x',
              textColor: Colors.white,
              onPressed: () {
                // code to be executed when the user dismisses the SnackBar
              },
            ),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Something went wrong',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: GlobalVariables.accentColor3,
            action: SnackBarAction(
              label: 'x',
              textColor: Colors.white,
              onPressed: () {
                // code to be executed when the user dismisses the SnackBar
              },
            ),
          ),
        );
      }
    } catch (error) {
      log('Error occurred duting HTTP request: $error');
    }
  }
}
