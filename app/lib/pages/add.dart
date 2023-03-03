/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:app/utils/global.vars.dart';

/*
  * Page/Component imports
 */
import '../components/baseplate.dart';
import '../components/editor.dart';
import '../components/snippet.save.dart';

class AddSnippet extends StatefulWidget {
  const AddSnippet({super.key});

  @override
  State<AddSnippet> createState() => _AddSnippetState();
}

class _AddSnippetState extends State<AddSnippet> {
  @override
  Widget build(BuildContext context) {
    return const Baseplate(
      title: 'Add Snippet',
      child: Content(),
    );
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

  // Clears the input field on reload
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _snippetController.clear();
    });
  }

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
              "Note: Syntax highlighting might not work for all languages & on page reload all inputted text dissapears",
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
                        return SaveSnippet(
                          snippetController: _snippetController,
                        );
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
