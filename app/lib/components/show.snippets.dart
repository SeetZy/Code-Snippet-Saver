/*
  * Utility imports
 */
import 'package:app/components/edit.snippet.dart';
import 'package:flutter/material.dart';
import 'package:app/utils/global.vars.dart';
import 'package:app/services/snippet.service.dart';
import 'package:app/services/user.info.dart';

class ShowSnippets extends StatefulWidget {
  const ShowSnippets({Key? key}) : super(key: key);

  @override
  State<ShowSnippets> createState() => _ShowSnippetsState();
}

class _ShowSnippetsState extends State<ShowSnippets> {
  // Controllers
  static final TextEditingController _snippetController =
      TextEditingController();
  static final TextEditingController _descriptionController =
      TextEditingController();

  // Loading state of the snippets
  bool _isLoading = false;

  // Method to load the snippets
  void _loadSnippets() async {
    setState(() {
      _isLoading = true;
    });

    await SnippetService.getSnippets((bool isLoading) {
      setState(() {
        _isLoading = isLoading;
      });
    });
  }

  // Lifecycle method to load the snippets
  @override
  void initState() {
    super.initState();
    _loadSnippets();
  }

  // Build method
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: _isLoading
          ? _buildLoadingState()
          : UserInfo.snippets == null || UserInfo.snippets!.isEmpty
              ? _buildEmptyState()
              : _buildGridView(context),
    );
  }

  // Widget to display when snippets are being loaded
  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  // Widget to display when there are no snippets
  Widget _buildEmptyState() {
    return const Center(
      child: Text(
        'This user doesn\'t have any snippets',
        style: TextStyle(fontSize: 18),
      ),
    );
  }

  // Widget to display the snippets
  Widget _buildGridView(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 90,
      height: MediaQuery.of(context).size.height - 118,
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 1,
        ),
        itemCount: UserInfo.snippets!.length,
        itemBuilder: (context, int index) {
          return InkWell(
            onTap: () {
              _snippetController.text = UserInfo.snippets![index]['snippet'];
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
                        EditSnippet(
                            title: '${UserInfo.snippets![index]['fileName']}',
                            snippetId: UserInfo.snippets![index]['_id'],
                            snippetController: _snippetController,
                            descriptionController: _descriptionController),
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
                  Text(
                    '${UserInfo.snippets![index]['fileName']}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
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
