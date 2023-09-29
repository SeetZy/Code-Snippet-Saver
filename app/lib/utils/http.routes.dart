class HttpRoutes {
  static const baseUrl = "http://localhost:5000/";

  // HTTP routes for user functions
  static const signUpUrl = '${baseUrl}signup';
  static const signInUrl = '${baseUrl}signin';
  static const updateUserData = '${baseUrl}update-user-data';
  static const deleteUser = '${baseUrl}delete-user';

  // HTTP routes for snippet functions
  static const addSnippetUrl = '${baseUrl}create-snippet';
  static const getUserSnippets = '${baseUrl}get-user-snippets';
  static const updateUserSnippets = '${baseUrl}update-snippets';
  static const deleteUserSnippets = '${baseUrl}delete-snippets';
}
