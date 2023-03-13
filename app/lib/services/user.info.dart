// This class provides a way to store and access user-related data from any file in the project
class UserInfo {
  // Store the username of the logged-in user
  static String? username;
  // Store the user ID of the logged-in user
  static String? userId;
  // Store the email address of the logged-in user
  static String? email;
  // Store a list of snippets created by the logged-in user
  static List? snippets;

  // This function filters the list of snippets based on the search text entered by the user
  static List<dynamic> filteredSnippets(searchText) {
    // If search text is empty, return all snippets
    if (searchText.isEmpty) {
      return UserInfo.snippets ?? [];
    } else {
      // Convert search text to lowercase for case-insensitive search
      final searchTextLower = searchText.toLowerCase();
      // Filter the snippets based on whether the file name contains the search text
      return (UserInfo.snippets ?? [])
          .where((snippet) =>
              snippet['fileName'].toLowerCase().contains(searchTextLower))
          .toList();
    }
  }
}
