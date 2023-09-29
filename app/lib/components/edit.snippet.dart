/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';
import 'package:app/services/snippet.service.dart';

/*
  * Page/Component imports
 */
import 'package:app/components/editor.dart';

class EditSnippet extends StatelessWidget {
  const EditSnippet(
      {super.key,
      required this.title,
      required this.snippetId,
      required this.snippetController,
      required this.descriptionController});

  final String title;
  // ignore: prefer_typing_uninitialized_variables
  final snippetId;
  final TextEditingController snippetController;
  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 25,
              color: GlobalVariables.accentColor2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Row(
          children: [
            // Code Editor
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.62,
                height: MediaQuery.of(context).size.height - 170,
                child: CodeEditor(
                  editorColor: Colors.white,
                  snippetController: snippetController,
                ),
              ),
            ),

            // Description
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Text(
                    "Description:",
                    style: TextStyle(fontSize: 20),
                  ),
                ),

                // Description text field

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height - 233,
                    child: TextField(
                      expands: true,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Code snippet description',
                        contentPadding: EdgeInsets.all(16.0),
                      ),
                      style: const TextStyle(fontSize: 16.0),
                      controller: descriptionController,
                      keyboardType: TextInputType.multiline,
                      textAlignVertical: TextAlignVertical.top,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
        Row(
          children: [
            SizedBox(width: MediaQuery.of(context).size.width - 800),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Button to save the edits
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: ElevatedButton(
                      onPressed: () {
                        SnippetService.updateSnippet(
                          context,
                          snippetId,
                          snippetController.text,
                          descriptionController.text,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: GlobalVariables.accentColor2),
                      child: const SizedBox(
                        width: 100,
                        child: Row(
                          children: [
                            Icon(
                              Icons.save_as,
                              color: Colors.white,
                            ),
                            Text(
                              ' Save Edits',
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

                  // Button to delete the snippet
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: ElevatedButton(
                      onPressed: () {
                        SnippetService.deleteSnippet(
                          context,
                          snippetId,
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: GlobalVariables.accentColor3),
                      child: const SizedBox(
                        width: 80,
                        child: Row(
                          children: [
                            Icon(
                              Icons.delete_outline,
                              color: Colors.white,
                            ),
                            Text(
                              ' Delete',
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
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: GlobalVariables.accentColor3),
                      child: const SizedBox(
                        width: 80,
                        child: Row(
                          children: [
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
            ),
          ],
        )
      ],
    );
  }
}
