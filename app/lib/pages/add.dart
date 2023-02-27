/*
  * Utility imports
 */
import 'package:flutter/material.dart';

/*
  * Page/Component imports
 */

import 'package:app/components/template.dart';
import 'package:pluto_code_editor/pluto_code_editor.dart';

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

class Content extends StatelessWidget {
  Content({super.key});

  PlutoCodeEditorController controller =
      PlutoCodeEditorController(theme: EditorTheme());

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 74,
        child: PlutoCodeEditor(controller: controller),
      ),
    );
  }
}
