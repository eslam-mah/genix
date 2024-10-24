import 'package:genix/features/chat%20screen/views/chat_listing_screen.dart';
import 'package:genix/features/chat%20screen/views/chat_screen.dart';
import 'package:genix/features/comments%20section/coments_router.dart';
import 'package:genix/features/comments%20section/replies.dart';
import 'package:genix/features/followers%20list%20page/followers_router.dart';
import 'package:genix/features/followers%20list%20page/my_followers_router.dart';
import 'package:genix/features/followings%20list%20page/followings_router.dart';
import 'package:genix/features/groups%20page/group_members_router.dart';
import 'package:genix/features/groups%20page/group_screen_router.dart';
import 'package:genix/features/groups%20page/groups_router.dart';
import 'package:genix/features/home%20screen/home_router.dart';
import 'package:genix/features/lock%20screen/lock_router.dart';
import 'package:genix/features/login%20screen/login_router.dart';
import 'package:genix/features/notifications%20screen/notifications_router.dart';
import 'package:genix/features/pages%20screen/page_screen_router.dart';
import 'package:genix/features/pages%20screen/pages_router.dart';
import 'package:genix/features/photos%20page/my_photos_router.dart';
import 'package:genix/features/photos%20page/photos_router.dart';
import 'package:genix/features/profile%20screen/My_profile_router.dart';
import 'package:genix/features/profile%20screen/profile_router.dart';
import 'package:genix/features/register%20screen/register.dart';
import 'package:genix/features/search%20page/search_router.dart';
import 'package:genix/features/settings%20screen/setting_router.dart';
import 'package:genix/features/splash%20screen/splashscreen.dart';
import 'package:genix/features/splash%20screen/views/custom_loading_page.dart';
import 'package:genix/features/support%20tickets%20screen/support_tickets_router.dart';
import 'package:genix/features/video%20shorts%20screen/video_shorts_router.dart';
import 'package:genix/features/videos%20page/my_videos_router.dart';
import 'package:genix/features/videos%20page/videos_router.dart';
import 'package:go_router/go_router.dart';

abstract class Rout {
  static const kRegister = '/register';
  static const kGlb = '/glb';
  static const kReplies = '/replies';
  static const kChatsListing = '/chat-listing';

  static const kChatScreen = '/chat';

  static const kLoadingPage = '/custom_loading_page';

  static final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: kRegister,
      builder: (context, state) => const Register(),
    ),
    GoRoute(
      path: kReplies,
      builder: (context, state) => const Replies(),
    ),

    GoRoute(
      path: kChatsListing,
      builder: (context, state) => const ChatListingScreen(),
    ),
    GoRoute(
      path: kChatScreen,
      builder: (context, GoRouterState pageState) {
        final date = pageState.extra as Map<String, dynamic>;
        return ChatScreen(
          chatRoom: date['chatRoom'],
        );
      },
    ),
    GoRoute(
      path: kLoadingPage,
      builder: (context, state) => const CustomLoadingPage(),
    ),

    /// group members
    ...GroupMembersRouter.goRoutes,

    /// photos
    ...PhotosRouter.goRoutes,

    /// my photos
    ...MyPhotosRouter.goRoutes,

    /// videos
    ...VideosRouter.goRoutes,

    /// my videos
    ...MyVideosRouter.goRoutes,

    /// my followers
    ...MyFollowersRouter.goRoutes,

    /// pages screen
    ...PagesScreenRouter.goRoutes,

    /// pages
    ...PagesRouter.goRoutes,

    /// groups screen
    ...GroupsScreenRouter.goRoutes,

    /// groups
    ...GroupsRouter.goRoutes,

    /// videos shorts

    ...VideoShortsRouter.goRoutes,

    /// comments
    ...CommentsRouter.goRoutes,

    /// home
    ...HomeRouter.goRoutes,

    /// lock
    ...LockRouter.goRoutes,

    /// search
    ...SearchRouter.goRoutes,

    /// profile
    ...ProfileRouter.goRoutes,

    /// notifications
    ...NotificationsRouter.goRoutes,

    /// followings
    ...FollowingsRouter.goRoutes,

    /// followers
    ...FollowersRouter.goRoutes,

    /// settings
    ...SettingRouter.goRoutes,

    /// support tickets
    ...SupportTicketsRouter.goRoutes,

    /// login
    ...LoginRouter.goRoutes,

    /// my profile
    ...MyProfileRouter.goRoutes,
  ]);
}
