/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:app/utils/global.vars.dart';
import 'package:app/services/snippet.service.dart';

class SaveSnippet extends StatefulWidget {
  const SaveSnippet({super.key, required this.snippetController});
  final TextEditingController snippetController;

  @override
  State<SaveSnippet> createState() => _SaveSnippetState();
}

class _SaveSnippetState extends State<SaveSnippet> {
  // Controllers
  static final TextEditingController _fileNameController =
      TextEditingController();
  // Controllers
  static final TextEditingController _descriptionController =
      TextEditingController();

  static final List<String> progLang = [
    'py',
    'dart',
    'js',
    'ts',
    'cpp',
    'cs',
    'php',
    'css',
    'html',
    'json'
  ];

  static String dropdownValue = 'py';

  // Clears the input field on reload
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _fileNameController.clear();
      _descriptionController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Pop-up widget content here
    return Container(
      color: GlobalVariables.secondaryColor,
      height: 300,
      child: Center(
        child: SizedBox(
          width: 800,
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
                  // Snippet info
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // File name
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
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

                          // File type
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            // File name text input field
                            child: DropdownButton<String>(
                              value: dropdownValue,
                              icon: const Icon(Icons.arrow_downward),
                              iconSize: 24,
                              items: progLang
                                  .map<DropdownMenuItem<String>>(
                                    (String value) => DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                            ),
                          ),
                        ],
                      ),

                      // Code snippet description
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: SizedBox(
                          width: 400,
                          height: 100,
                          child: TextField(
                            expands: true,
                            maxLines: null,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText:
                                  'Code snippet description', // add this line
                              contentPadding: EdgeInsets.all(16.0),
                            ),
                            style: const TextStyle(fontSize: 16.0),
                            controller: _descriptionController,
                            keyboardType: TextInputType.multiline,
                            textAlignVertical: TextAlignVertical.top,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Button to save the snippet
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            // Get the controller input as text
                            final String fileName = _fileNameController.text;
                            final String fileType = dropdownValue;
                            final String snippet =
                                widget.snippetController.text;
                            final String description =
                                _descriptionController.text;

                            SnippetService.saveCodeSnippet(
                              context,
                              fileName,
                              fileType,
                              snippet,
                              description,
                              widget.snippetController,
                            );
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
                      ),

                      // Button to close the menu
                      Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: GlobalVariables.accentColor3),
                          child: SizedBox(
                            width: 80,
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.close,
                                  color: Colors.white,
                                ),
                                Text(
                                  ' Close',
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
                    ],
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
