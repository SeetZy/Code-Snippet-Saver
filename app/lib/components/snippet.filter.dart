import 'package:app/utils/global.vars.dart';
import 'package:flutter/material.dart';

class SnippetFilter extends StatelessWidget {
  const SnippetFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 994,
      height: MediaQuery.of(context).size.height - 120,
      color: GlobalVariables.primaryColor,
    );
  }
}
