/*
  * Utility imports
 */
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';

class CodeEditor extends StatelessWidget {
  const CodeEditor({
    Key? key,
    required this.snippetController,
    required this.editorColor,
  }) : super(key: key);

  final Color editorColor;
  final TextEditingController snippetController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: editorColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextField(
          expands: true,
          maxLines: null,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: GlobalVariables.defaultCode.join('\n'),
            hintStyle: TextStyle(color: editorColor),
            contentPadding: const EdgeInsets.all(16.0),
          ),
          style: TextStyle(fontSize: 16.0, color: editorColor),
          controller: snippetController,
          keyboardType: TextInputType.multiline,
          scrollPhysics: const BouncingScrollPhysics(),
          textAlignVertical: TextAlignVertical.top,
          textAlign: TextAlign.left,
          cursorColor: editorColor,
          cursorWidth: 1.5,
          cursorHeight: 18.0,
          cursorRadius: const Radius.circular(2.0),
          onChanged: (text) {},
          onSubmitted: (text) {},
          autocorrect: false,
          enableSuggestions: false,
          enableInteractiveSelection: true,
          showCursor: true,
          selectionControls: MaterialTextSelectionControls(),
        ),
      ),
    );
  }
}
