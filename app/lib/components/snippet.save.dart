/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import '../utils/global.vars.dart';
import '../services/snippet.service.dart';

class SaveSnippet extends StatelessWidget {
  const SaveSnippet({super.key, required this.snippetController});

  // Controllers
  static final TextEditingController _fileNameController =
      TextEditingController();
  static final TextEditingController _fileTypeController =
      TextEditingController();
  final TextEditingController snippetController;

  @override
  Widget build(BuildContext context) {
    // Pop-up widget content here
    return Container(
      color: GlobalVariables.secondaryColor,
      height: MediaQuery.of(context).size.height * 0.3,
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
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
                      // Get the controller input as text
                      final String fileName = _fileNameController.text;
                      final String fileType = _fileTypeController.text;
                      final String snippet = snippetController.text;

                      SaveCodeSnippet.saveCodeSnippet(
                          fileName, fileType, snippet);
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
