/*
  * Utility imports
 */
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';
// ? https://pub.dev/packages/http
import 'package:http/http.dart' as http;
// ? https://pub.dev/packages/jwt_decoder
import 'package:jwt_decoder/jwt_decoder.dart';

/*
  * Page/Component imports
 */
import '../components/baseplate.dart';
import '../components/editor.dart';
import '../utils/http.routes.dart';

class AddSnippet extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final token;
  const AddSnippet({super.key, @required this.token});

  @override
  State<AddSnippet> createState() => _AddSnippetState();
}

class _AddSnippetState extends State<AddSnippet> {
  // ignore: unused_field
  static late String userId;

  @override
  void initState() {
    super.initState();
    if (widget.token != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
      userId = jwtDecodedToken['_id'];
    }
  }

  static void saveSnippet() async {
    // Checks if the text fields are filled
    if (_ContentState._snippetController.text.isNotEmpty &&
        _SaveSnippetState._fileNameController.text.isNotEmpty &&
        _SaveSnippetState._fileTypeController.text.isNotEmpty) {
      var regBody = {
        "fileName": _SaveSnippetState._fileNameController.text,
        "fileType": _SaveSnippetState._fileTypeController.text,
        "snippet": _ContentState._snippetController.text,
      };

      var response = await http.post(
        Uri.parse(HttpRoutes.addSnippetUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );

      var jsonResponse = jsonDecode(response.body);

      if (jsonResponse['status']) {
        log('Added the code snippet');
      } else {
        log('something went wrong');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Baseplate(title: 'Add Snippet', child: Content());
  }
}

class Content extends StatefulWidget {
  const Content({super.key});

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  static final TextEditingController _snippetController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            "New Code Snippet",
            style: TextStyle(
                fontSize: 25,
                color: GlobalVariables.accentColor4,
                fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: CodeEditor(
            snippetController: _snippetController,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              "Note: Syntax highlighting might not work for all languages",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    // Pop up screen to add new patients
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return const SaveSnippet();
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: GlobalVariables.accentColor2),
                  child: SizedBox(
                    width: 65,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                        Text(
                          ' Save',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class SaveSnippet extends StatefulWidget {
  const SaveSnippet({super.key});

  @override
  State<SaveSnippet> createState() => _SaveSnippetState();
}

class _SaveSnippetState extends State<SaveSnippet> {
  static final TextEditingController _fileNameController =
      TextEditingController();
  static final TextEditingController _fileTypeController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Pop-up widget content here
    return Container(
      color: GlobalVariables.secondaryColor,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 40),
                child: Text(
                  "Save a snippet",
                  style: TextStyle(
                      color: GlobalVariables.accentColor4,
                      fontSize: 25,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        // File name text input field
                        child: SizedBox(
                          width: 300,
                          child: TextField(
                            controller: _fileNameController,
                            decoration: const InputDecoration(
                              hintText: "File name e.g. main.py",
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(20),
                          // File name text input field
                          child: SizedBox(
                            width: 300,
                            child: TextField(
                              controller: _fileTypeController,
                              decoration: const InputDecoration(
                                hintText: "File type e.g. python",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          )),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _AddSnippetState.saveSnippet();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: GlobalVariables.accentColor2),
                    child: SizedBox(
                      width: 120,
                      child: Row(
                        children: const [
                          Icon(
                            Icons.save,
                            color: Colors.white,
                          ),
                          Text(
                            ' Save Snippet',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
