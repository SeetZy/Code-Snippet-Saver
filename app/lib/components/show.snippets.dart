/*
  * Utility imports
 */
import 'package:app/services/snippet.service.dart';
import 'package:flutter/material.dart';
import 'package:app/services/user.info.dart';
import '../utils/global.vars.dart';
import 'package:app/components/editor.dart';

class ShowSnippets extends StatelessWidget {
  const ShowSnippets({super.key});

  static final TextEditingController _snippetController =
      TextEditingController();
  static final TextEditingController _descriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Shows every available code snippet that is saved to the user
    return Padding(
      padding: const EdgeInsets.all(10),
      child: UserInfo.snippets == null
          ? const Center(
              child: Text(
                "This user doesn't have any snippets",
                style: TextStyle(fontSize: 20),
              ),
            )
          : SizedBox(
              width: MediaQuery.of(context).size.width - 90,
              height: MediaQuery.of(context).size.height - 118,
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 1,
                ),
                itemCount: UserInfo.snippets!.length,
                itemBuilder: (context, int index) {
                  // When a code snippet is clicked
                  return GestureDetector(
                    onTap: () {
                      _snippetController.text =
                          UserInfo.snippets![index]['snippet'];
                      _descriptionController.text =
                          UserInfo.snippets![index]['description'];
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: GlobalVariables.secondaryColor,
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: Text(
                                    '${UserInfo.snippets![index]['fileName']}',
                                    style: const TextStyle(
                                      fontSize: 25,
                                      color: GlobalVariables.accentColor4,
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
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.62,
                                        height:
                                            MediaQuery.of(context).size.height -
                                                170,
                                        child: CodeEditor(
                                          snippetController: _snippetController,
                                        ),
                                      ),
                                    ),

                                    // Description
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            "Description:",
                                            style: TextStyle(fontSize: 20),
                                          ),
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.2,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height -
                                              233,
                                          child: TextField(
                                            expands: true,
                                            maxLines: null,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              hintText:
                                                  'Code snippet description', // add this line
                                              contentPadding:
                                                  EdgeInsets.all(16.0),
                                            ),
                                            style:
                                                const TextStyle(fontSize: 16.0),
                                            controller: _descriptionController,
                                            keyboardType:
                                                TextInputType.multiline,
                                            textAlignVertical:
                                                TextAlignVertical.top,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: MediaQuery.of(context)
                                                .size
                                                .width -
                                            800), // Empty SizedBox to push the buttons to the right side
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          // Button to save the edits
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      GlobalVariables
                                                          .accentColor2),
                                              child: SizedBox(
                                                width: 100,
                                                child: Row(
                                                  children: const [
                                                    Icon(
                                                      Icons.save_as,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      ' Save Edits',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),

                                          // Button to delete the snippet
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                SnippetService.deleteSnippet(
                                                    context,
                                                    UserInfo.snippets![index]
                                                        ['_id']);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      GlobalVariables
                                                          .accentColor3),
                                              child: SizedBox(
                                                width: 80,
                                                child: Row(
                                                  children: const [
                                                    Icon(
                                                      Icons.delete_outline,
                                                      color: Colors.white,
                                                    ),
                                                    Text(
                                                      ' Delete',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),

                                          // Button to close the menu
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      GlobalVariables
                                                          .accentColor3),
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
                                                          fontWeight:
                                                              FontWeight.bold),
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
                            ),
                          );
                        },
                      );
                    },
                    child: Card(
                      color: GlobalVariables.secondaryColor2,
                      borderOnForeground: false,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.file_open, size: 50),
                          Text('${UserInfo.snippets![index]['fileName']}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight
                                      .bold)), // The main text to display
                          const SizedBox(
                              height: 10), // The secondary text to display
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
