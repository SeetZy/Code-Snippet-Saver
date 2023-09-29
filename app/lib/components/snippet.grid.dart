/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/services/user.info.dart';
import 'package:app/utils/icons.dart';
import 'package:app/utils/global.vars.dart';

/*
  * Page/Component imports
 */
import 'package:app/components/edit.snippet.dart';

class SnippetGrid extends StatefulWidget {
  const SnippetGrid({super.key, required this.searchedText});

  final String searchedText;

  @override
  State<SnippetGrid> createState() => _SnippetGridState();
}

class _SnippetGridState extends State<SnippetGrid> {
  // Controllers
  static final TextEditingController _snippetController =
      TextEditingController();
  static final TextEditingController _descriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 90,
      height: MediaQuery.of(context).size.height - 201,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1,
        ),
        itemCount: UserInfo.filteredSnippets(widget.searchedText).length,
        itemBuilder: (context, int index) {
          final snippet = UserInfo.filteredSnippets(widget.searchedText)[index];
          return InkWell(
            onTap: () {
              // Sets the controller text
              _snippetController.text = snippet['snippet'];
              _descriptionController.text = snippet['description'];

              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: GlobalVariables.primaryColor,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Pop up to edit the snippet data
                        EditSnippet(
                          title: '${snippet['fileName']}',
                          snippetId: snippet['_id'],
                          snippetController: _snippetController,
                          descriptionController: _descriptionController,
                        ),
                      ],
                    ),
                  );
                },
              );
            },

            // Individual card with some info about the snippet
            child: Card(
              color: GlobalVariables.primaryColor,
              borderOnForeground: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProgrammingIcons.icons(snippet['fileType']),
                  Text(
                    '${snippet['fileName']}',
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
