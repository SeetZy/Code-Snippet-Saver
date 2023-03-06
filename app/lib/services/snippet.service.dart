// ignore_for_file: use_build_context_synchronously

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
  // Function to save a snippet
  static saveCodeSnippet(
      BuildContext context, fileName, fileType, snippet, description) async {
    // Checks if the code snippet data is empty or not
    if (fileName.isNotEmpty &&
        fileType.isNotEmpty &&
        snippet.isNotEmpty &&
        description.isNotEmpty) {
      try {
        // Show loading bar
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const Center(child: CircularProgressIndicator());
          },
        );

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
          // Closes the loading bar
          Navigator.of(context).pop();
          // Closes the pop up menu
          Navigator.of(context).pop();
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

  // Function to update a snippet
  static Future<void> updateSnippet(
      BuildContext context, id, snippet, description) async {
    try {
      // Show loading bar
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      var regBody = jsonEncode({
        "snippet": snippet,
        "description": description,
      });

      var response = await http.put(
        Uri.parse('${HttpRoutes.updateUserSnippets}/$id'),
        headers: {"Content-Type": "application/json"},
        body: regBody,
      );

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status']) {
        // Closes the loading bar
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
              'Successfully updated the snippet',
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
      log('Error occurred during HTTP request: $error');
    }
  }

  // Function to delete a snippet
  static void deleteSnippet(BuildContext context, id) async {
    try {
      // Show loading bar
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const Center(child: CircularProgressIndicator());
        },
      );

      var regBody = {"id": id};

      var response = await http.post(
        Uri.parse(HttpRoutes.deleteUserSnippets),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        // Closes the loading bar
        Navigator.of(context).pop();
        // Closes the popup menu
        Navigator.of(context).pop();
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
