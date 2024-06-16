class ApiEndPoints {
  static const String baseUrl = 'https://api.genix.social/api';
  //log in
  static const String logIn = baseUrl + "/login";
  // users
  static const String getUsers = baseUrl + "/accounts/users";
  static const String getBlockedUsers = baseUrl + "/accounts/blocks";
  static const String getRestrictedUsers = baseUrl + "/accounts/restricts";
  static const String getMyRestrictedUsers = baseUrl + "/accounts/restrict/my";
  static const String postRestrictUser = baseUrl + "/accounts/restrict";
  static const String postBlockUser = baseUrl + "/accounts/block";
  static const String deleteBlockUser = baseUrl + "/accounts/block";
  static const String updateUser = baseUrl + "/accounts/user";
  static const String deleteUser = baseUrl + "/accounts/user";
}
