/*
  * Utility imports
 */
import 'dart:async';
import 'package:app/components/snippet.grid.dart';
import 'package:flutter/material.dart';
import 'package:app/services/snippet.service.dart';
import 'package:app/services/user.info.dart';

/*
  * Page/Component imports
 */
import 'package:app/components/states/empty.state.dart';
import 'package:app/components/states/loading.state.dart';

class ShowSnippets extends StatefulWidget {
  const ShowSnippets({Key? key}) : super(key: key);

  @override
  State<ShowSnippets> createState() => _ShowSnippetsState();
}

class _ShowSnippetsState extends State<ShowSnippets> {
  // Controllers
  static final TextEditingController _searchController =
      TextEditingController();

  // Sets the default value for the searched text
  static String _searchText = '';

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

  // Method when the searched text is changed
  void _onSearchTextChanged(String searchText) {
    setState(() {
      _searchText = searchText;
    });
  }

  // Lifecycle method to load the snippets
  @override
  void initState() {
    super.initState();
    _loadSnippets();

    // Set up a timer to update the search text every second
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  // Build method
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: SizedBox(
                  width: 300,
                  child: TextFormField(
                    controller: _searchController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: "Search by file name",
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                    ),
                    onChanged: _onSearchTextChanged,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          _isLoading
              // When the data is being loaded from the database
              ? const LoadingState()
              : UserInfo.snippets == null || UserInfo.snippets!.isEmpty
                  // If there is no data
                  ? const EmptyState()
                  // If there is data
                  : SnippetGrid(
                      searchedText: _searchText,
                    ),
        ],
      ),
    );
  }
}
