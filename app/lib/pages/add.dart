/*
  * Utility imports
 */
import 'package:app/utils/global.vars.dart';
import 'package:flutter/material.dart';
// ? https://pub.dev/packages/code_editor
import 'package:code_editor/code_editor.dart';

/*
  * Page/Component imports
 */
import 'package:app/components/save.popup.dart';
import 'package:app/components/template.dart';

class AddSnippet extends StatelessWidget {
  const AddSnippet({super.key});

  @override
  Widget build(BuildContext context) {
    return Template(
      title: 'Add Snippet',
      child: Content(),
    );
  }
}

// ignore: must_be_immutable
class Content extends StatelessWidget {
  Content({super.key});

  // Controllers
  final TextEditingController _codeEditor = TextEditingController();
  late String code = "";

  @override
  Widget build(BuildContext context) {
    // Defines default code that is in the fle
    List<String> page = [
      '# Default code',
      'class Car:',
      '\tdef __init__(self, make, model):',
      '\t\tself.make = make>',
      '\t\tself.model = model',
      '',
      '\tdef start(self):',
      '\t\tprint(f"{self.make} {self.model} is starting.")',
      '',
      'car = Car("Toyota", "Corolla")',
      'car.start()'
    ];

    // Defines the coding file
    List<FileEditor> file = [
      FileEditor(
        name: "New Code Snippet",
        language: 'ruby',
        code: page.join("\n"),
      ),
    ];

    // Sets the editor style
    EditorModel model = EditorModel(
      files: file,
      styleOptions: EditorModelStyleOptions(
          fontSize: 15,
          fontSizeOfFilename: 20,
          heightOfContainer: MediaQuery.of(context).size.height - 160,
          editButtonTextColor: Colors.white,
          editButtonBackgroundColor: GlobalVariables.accentColor2),
    );

    return Column(
      children: [
        Expanded(
          child: CodeEditor(
            model: model,
            edit: true,
            disableNavigationbar: false,
            textEditingController: _codeEditor,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton(
            onPressed: () {
              // Get the controller input as text
              String codeSnippet = _codeEditor.text;

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
              width: 60,
              child: Row(
                children: const [
                  Icon(
                    Icons.save,
                    color: Colors.white,
                  ),
                  Text(
                    ' Save',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
