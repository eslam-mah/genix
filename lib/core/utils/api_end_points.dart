class ApiEndPoints {
  static const String baseUrl = 'https://api.genix.social/api';
  // register

  //log in
  static const String logIn = "$baseUrl/login";
  // log out
  static const String logOut = "$baseUrl/logout";
  // users
  static const String getUsers = "$baseUrl/accounts/users";
  static const String getBlockedUsers = "$baseUrl/accounts/blocks";
  static const String getRestrictedUsers = "$baseUrl/accounts/restricts";
  static const String getMyRestrictedUsers = "$baseUrl/accounts/restrict/my";
  static const String postRestrictUser = "$baseUrl/accounts/restrict";
  static const String postBlockUser = "$baseUrl/accounts/block";
  static const String deleteBlockUser = "$baseUrl/accounts/block";
  static const String updateUser = "$baseUrl/accounts/user";
  static const String deleteUser = "$baseUrl/accounts/user";
  // first load
  static const String getFirstLoad = "$baseUrl/firstload";
  // tickets
  static const String getAllTickets = "$baseUrl/app/tickets";
  static const String getTicketById = "$baseUrl/app/ticket";
  static const String postTicket = "$baseUrl/app/ticket";
  static const String updateTicket = "$baseUrl/app/ticket";
  static const String updateTicketStatus = "$baseUrl/app/ticket/status";
  static const String deleteTicket = "$baseUrl/app/ticket";
  static const String postTicketComment = "$baseUrl/app/tickets/comment";
  static const String updateTicketComment = "$baseUrl/app/tickets/comment/";
  static const String deleteTicketComment = "$baseUrl/app/tickets/comment/";
  // settings
  static const String getMyAccount = "$baseUrl/accounts/me";
  static const String updateMyAccount = "$baseUrl/accounts/me";
  static const String updateMyAccountProfile = "$baseUrl/accounts/me/profile";
  static const String updateGeneralSetting = "$baseUrl/accounts/me/general";
  static const String updateMyPassword = "$baseUrl/accounts/me/security";
  static const String updateMyEmail = "$baseUrl/accounts/me/emails";
  static const String updateStatus = "$baseUrl/accounts/me/status";
  static const String deleteMyAccount = "$baseUrl/accounts/me";
  static const String getAllTransactions = "$baseUrl/accounts/me/transactions";
  static const String getAllPayouts = "$baseUrl/accounts/me/payouts";
  static const String postPayout = "$baseUrl/accounts/me/payout";
  // get profile
  static const String getProfile = "$baseUrl/accounts/profile";
  // friendships
  static const String getFollowers = "$baseUrl/accounts/friendships/followers";
  static const String getFollowings = "$baseUrl/accounts/friendships/following";
  static const String addFriend = "$baseUrl/accounts/friendship";
  static const String updateCloseFriend = "$baseUrl/accounts/friendship";
  static const String removeFriend = "$baseUrl/accounts/friendship";
  // notifications
  static const String getNotifications = "$baseUrl/app/notifications";
  static const String updateNotifications = "$baseUrl/app/notifications";
  // search
  static const String search = "$baseUrl/app/search";
  // lock screen
  static const String getLock = "$baseUrl/auth/lock";
  static const String postLock = "$baseUrl/auth/lock";
  static const String removeLock = "$baseUrl/auth/lock";
  // documents
  static const String getDocuments = "$baseUrl/app/documents";
  static const String getDocumentById = "$baseUrl/app/document";
  // report
  static const String postReport = "$baseUrl/app/report";
  // post
  static const String addPost = "$baseUrl/post";
  static const String getPostById = "$baseUrl/post";
  static const String updatePostById = "$baseUrl/post";
  static const String addPollPost = "$baseUrl/post/poll";
  static const String deletePost = "$baseUrl/post";
  static const String reactOnPost = "$baseUrl/posts/react";
  static const String sharePost = "$baseUrl/posts/share";
  static const String addComment = "$baseUrl/posts/comment";
  static const String deleteComment = "$baseUrl/posts/comment";
  static const String reactOnComment = "$baseUrl/posts/react/comment";
  static const String getReaction = "$baseUrl/posts/reactions";
  static const String getPostsInTimeLineById = "$baseUrl/posts/timeline";
  static const String getPostsInNewsFeed = "$baseUrl/posts/newsfeed";
  static const String getPhotoPosts = "$baseUrl/posts/photos";
  static const String getVideoPosts = "$baseUrl/posts/videos";
  static const String getStories = "$baseUrl/posts/stories";
  static const String getStoryViewers = "$baseUrl/posts/story/viewers";
  static const String makeStorySeen = "$baseUrl/posts/story/seen";
  static const String addReactOnStory = "$baseUrl/posts/story/react";
  static const String savePost = "$baseUrl/posts/save";
  static const String viewPost = "$baseUrl/posts/view";
  static const String addDonation = "$baseUrl/posts/donate";
  static const String getLiveChannel = "$baseUrl/posts/live/channel";
  static const String deleteUserPost = "$baseUrl/accounts/user/posts";
  static const String deleteUserComment =
      "$baseUrl/accounts/user/posts/comments";
  // shorts
  static const String getShorts = "$baseUrl/posts/shorts";
  static const String getSavedShorts = "$baseUrl/posts/shorts/saved";
  static const String getPostedShorts = "$baseUrl/posts/shorts/posted";
  static const String searchShorts = "$baseUrl/posts/shorts/search";
  static const String addShort = "$baseUrl/posts/short";
  static const String updateShort = "$baseUrl/posts/short";
  // groups
  static const String getGroupsList = "$baseUrl/groups";
  static const String getGroup = "$baseUrl/group";
  static const String createGroup = "$baseUrl/group";
  static const String updateGroupDetails = "$baseUrl/group";
  static const String updateGroupProfile = "$baseUrl/group/profile";
  static const String deleteGroup = "$baseUrl/group";
  static const String postRateOnGroup = "$baseUrl/group/rate";
  static const String getGroupPhotos = "$baseUrl/group/photos";
  static const String joinGroupPost = "$baseUrl/group/join";
  static const String removeJoin = "$baseUrl/group/join";
  static const String postGroupInvitations = "$baseUrl/group/join/invitation";
  static const String updateInvitation = "$baseUrl/group/join/invitation";
  static const String getAllMembers = "$baseUrl/group/members";
  static const String updateGroupMember = "$baseUrl/group/member";
  static const String deleteGroupMember = "$baseUrl/group/member";
  static const String deleteGroupMemberPost = "$baseUrl/group/member/posts";
  static const String deleteGroupMemberComment =
      "$baseUrl/group/member/posts/comments";
  // pages
  static const String getPagesList = "$baseUrl/pages";
  static const String getPage = "$baseUrl/page";
  static const String createPage = "$baseUrl/page";
  static const String updatePageDetails = "$baseUrl/page";
  static const String updatePageProfile = "$baseUrl/page/profile";
  static const String deletePage = "$baseUrl/page";
  static const String postRateOnPage = "$baseUrl/page/rate";
  static const String getPagePhotos = "$baseUrl/page/photos";
  static const String followPagePost = "$baseUrl/page/follow";
  static const String removePageFollow = "$baseUrl/page/follow";
  static const String postPageInvitations = "$baseUrl/page/follow/invitation";
  static const String updatePageInvitation = "$baseUrl/page/follow/invitation";
  static const String getAllPagesMembers = "$baseUrl/page/members";
  static const String updatePageMember = "$baseUrl/page/member";
  static const String deletePageMember = "$baseUrl/page/member";
  static const String deletePageMemberPost = "$baseUrl/page/member/posts";
  static const String deletePageMemberComment =
      "$baseUrl/page/member/posts/comments";
}
