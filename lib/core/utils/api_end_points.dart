class ApiEndPoints {
  static const String baseUrl = 'https://api.genix.social/api';
  // register

  //log in
  static const String logIn = baseUrl + "/login";
  // log out
  static const String logOut = baseUrl + "/logout";
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
  // first load
  static const String getFirstLoad = baseUrl + "/firstload";
  // tickets
  static const String getAllTickets = baseUrl + "/app/tickets";
  static const String getTicketById = baseUrl + "/app/ticket";
  static const String postTicket = baseUrl + "/app/ticket";
  static const String updateTicket = baseUrl + "/app/ticket";
  static const String updateTicketStatus = baseUrl + "/app/ticket/status";
  static const String deleteTicket = baseUrl + "/app/ticket";
  static const String postTicketComment = baseUrl + "/app/tickets/comment";
  static const String updateTicketComment = baseUrl + "/app/tickets/comment/";
  static const String deleteTicketComment = baseUrl + "/app/tickets/comment/";
  // settings
  static const String getMyAccount = baseUrl + "/accounts/me";
  static const String updateMyAccount = baseUrl + "/accounts/me";
  static const String updateMyAccountProfile = baseUrl + "/accounts/me/profile";
  static const String updateGeneralSetting = baseUrl + "/accounts/me/general";
  static const String updateMyPassword = baseUrl + "/accounts/me/security";
  static const String updateMyEmail = baseUrl + "/accounts/me/emails";
  static const String updateStatus = baseUrl + "/accounts/me/status";
  static const String deleteMyAccount = baseUrl + "/accounts/me";
  static const String getAllTransactions =
      baseUrl + "/accounts/me/transactions";
  static const String getAllPayouts = baseUrl + "/accounts/me/payouts";
  static const String postPayout = baseUrl + "/accounts/me/payout";
  // get profile
  static const String getProfile = baseUrl + "/accounts/profile";
  // friendships
  static const String getFollowers =
      baseUrl + "/accounts/friendships/followers";
  static const String getFollowings =
      baseUrl + "/accounts/friendships/following";
  static const String addFriend = baseUrl + "/accounts/friendship";
  static const String updateCloseFriend = baseUrl + "/accounts/friendship";
  static const String removeFriend = baseUrl + "/accounts/friendship";
  // notifications
  static const String getNotifications = baseUrl + "/app/notifications";
  static const String updateNotifications = baseUrl + "/app/notifications";
  // search
  static const String search = baseUrl + "/app/search";
  // lock screen
  static const String getLock = baseUrl + "/auth/lock";
  static const String postLock = baseUrl + "/auth/lock";
  static const String removeLock = baseUrl + "/auth/lock";
  // documents
  static const String getDocuments = baseUrl + "/app/documents";
  static const String getDocumentById = baseUrl + "/app/document";
  // report
  static const String postReport = baseUrl + "/app/report";
}
