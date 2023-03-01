/*
  * Utility imports
 */
import 'package:app/utils/global.vars.dart';
import 'package:flutter/material.dart';
// ? https://pub.dev/packages/code_editor
import 'package:code_editor/code_editor.dart';
// ? https://pub.dev/packages/jwt_decoder
import 'package:jwt_decoder/jwt_decoder.dart';

/*
  * Page/Component imports
 */
import 'package:app/components/save.popup.dart';
import '../components/baseplate.dart';

class AddSnippet extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final token;
  const AddSnippet({super.key, @required this.token});

  @override
  State<AddSnippet> createState() => _AddSnippetState();
}

class _AddSnippetState extends State<AddSnippet> {
  static late String email;
  @override
  void initState() {
    super.initState();
    if (widget.token != null) {
      Map<String, dynamic> jwtDecodedToken = JwtDecoder.decode(widget.token);
      email = jwtDecodedToken['email'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Baseplate(
      title: 'Add',
      child: Content(),
    );
  }
}

class Content extends StatelessWidget {
  Content({super.key});
// Controllers
  final TextEditingController _codeEditor = TextEditingController();

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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              "Languages supported by syntax highlighting: Python, Ruby, JavaScript, HTML, CSS",
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
                          codeSnippet: _codeEditor,
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
