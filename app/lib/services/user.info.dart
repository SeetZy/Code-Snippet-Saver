// Makes user related data accessible by any file
class UserInfo {
  static String? username;
  static String? userId;
  static String? email;
  static List? snippets;

  static List<dynamic> filteredSnippets(searchText) {
    if (searchText.isEmpty) {
      return UserInfo.snippets ?? [];
    } else {
      final searchTextLower = searchText.toLowerCase();
      return (UserInfo.snippets ?? [])
          .where((snippet) =>
              snippet['fileName'].toLowerCase().contains(searchTextLower))
          .toList();
    }
  }
}
