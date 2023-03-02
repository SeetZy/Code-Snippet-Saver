/*
  * Utility imports
 */
import 'package:flutter/material.dart';

class CodeEditor extends StatelessWidget {
  const CodeEditor({
    Key? key,
    required this.snippetController,
  }) : super(key: key);

  final TextEditingController snippetController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        expands: true,
        maxLines: null,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          hintText:
              '# Default code\n\nclass Car:\n\tdef __init__(self, make, model):\n\t\tself.make = make>\n\t\tself.model = model\n\n\tdef start(self):\n\t\tprint(f"{self.make} {self.model} is starting.")\n\ncar = Car("Toyota", "Corolla")\ncar.start()',
          contentPadding: EdgeInsets.all(16.0),
        ),
        style: const TextStyle(fontSize: 16.0),
        controller: snippetController,
        keyboardType: TextInputType.multiline,
        scrollPhysics: const BouncingScrollPhysics(),
        textAlignVertical: TextAlignVertical.top,
        textAlign: TextAlign.left,
        cursorColor: Colors.blue,
        cursorWidth: 2.0,
        cursorHeight: 24.0,
        cursorRadius: const Radius.circular(2.0),
        onChanged: (text) {},
        onSubmitted: (text) {},
        autocorrect: false,
        enableSuggestions: false,
        enableInteractiveSelection: true,
        showCursor: true,
        toolbarOptions: const ToolbarOptions(
          copy: true,
          cut: true,
          paste: true,
          selectAll: true,
        ),
        selectionControls: MaterialTextSelectionControls(),
      ),
    );
  }
}
