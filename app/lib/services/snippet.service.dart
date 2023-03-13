// ignore_for_file: use_build_context_synchronously

/*
  * Utility imports
 */
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';
import 'package:app/services/user.info.dart';
import 'package:app/utils/http.routes.dart';
// ? https://pub.dev/packages/http
import 'package:http/http.dart' as http;

/*
  * Page/Component imports
 */
import 'package:app/components/toasts.dart';

// A class for managing code snippets
class SnippetService {
  // Function to get user snippets
  static Future<void> getSnippets(Function(bool) setLoading) async {
    try {
      setLoading(true);

      // HTTP GET request
      final response = await http.get(
        Uri.parse('${HttpRoutes.getUserSnippets}?userId=${UserInfo.userId}'),
        headers: {"Content-Type": "application/json"},
      );

      final jsonResponse = jsonDecode(response.body);

      if (jsonResponse['success'] != null) {
        UserInfo.snippets = jsonResponse['success'];
      } else {
        UserInfo.snippets = [];
      }

      setLoading(false);
    } catch (error) {
      log('An error occurred whilst doing a HTTP request: $error');
    }
  }

  // Function to save a snippet
  static void saveCodeSnippet(BuildContext context, fileName, fileType, snippet,
      description, TextEditingController snippetController) async {
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

        // HTTP POST request
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

          // CLears the snippet controller
          snippetController.clear();

          Toast.toastMsg(context, 'Successfully added a code snippet',
              GlobalVariables.accentColor2);
        } else {
          Toast.toastMsg(
              context, 'Something went wrong', GlobalVariables.accentColor3);
        }
      } catch (error) {
        log('Error occurred duting HTTP request: $error');
      }
    } else {
      Toast.toastMsg(
          context, 'Please fill all the fields', GlobalVariables.accentColor3);
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

      // HTTP PUT request
      var response = await http.put(
        Uri.parse('${HttpRoutes.updateUserSnippets}/$id'),
        headers: {"Content-Type": "application/json"},
        body: regBody,
      );

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status']) {
        // Closes the loading bar
        Navigator.of(context).pop();

        Toast.toastMsg(context, 'Successfully updated the snippet',
            GlobalVariables.accentColor2);

        getSnippets((p0) => null);
      } else {
        Toast.toastMsg(
            context, 'Something went wrong', GlobalVariables.accentColor3);
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

      // HTTP DELETE request
      var response = await http.delete(
        Uri.parse(HttpRoutes.deleteUserSnippets),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        // Remove the deleted snippet from the UserInfo.snippets list
        UserInfo.snippets?.removeWhere((snippet) => snippet['_id'] == id);

        // Closes the loading bar
        Navigator.of(context).pop();
        // Closes the popup menu
        Navigator.of(context).pop();

        Toast.toastMsg(context, 'Successfully deleted a code snippet',
            GlobalVariables.accentColor2);

        getSnippets((p0) => null);
      } else {
        Toast.toastMsg(context, 'Something went wrong. Please try again',
            GlobalVariables.accentColor3);
      }
    } catch (error) {
      log('Error occurred duting HTTP request: $error');
    }
  }
}
