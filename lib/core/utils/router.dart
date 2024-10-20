import 'package:genix/features/chat%20screen/views/chat_listing_screen.dart';
import 'package:genix/features/chat%20screen/views/chat_screen.dart';
import 'package:genix/features/comments%20section/coments_router.dart';
import 'package:genix/features/comments%20section/replies.dart';
import 'package:genix/features/followers%20list%20page/followers_router.dart';
import 'package:genix/features/followings%20list%20page/followings_router.dart';
import 'package:genix/features/groups%20page/groupsscreen.dart';
import 'package:genix/features/home%20screen/home_router.dart';
import 'package:genix/features/lock%20screen/lock_router.dart';
import 'package:genix/features/login%20screen/login_router.dart';
import 'package:genix/features/notifications%20screen/notifications_router.dart';
import 'package:genix/features/pages%20list%20page/pagesscreen.dart';
import 'package:genix/features/photos%20page/photosscreen.dart';
import 'package:genix/features/profile%20screen/My_profile_router.dart';
import 'package:genix/features/profile%20screen/profile_router.dart';
import 'package:genix/features/register%20screen/register.dart';
import 'package:genix/features/search%20page/search_router.dart';
import 'package:genix/features/settings%20screen/setting_router.dart';
import 'package:genix/features/splash%20screen/splashscreen.dart';
import 'package:genix/features/support%20tickets%20screen/support_tickets_router.dart';
import 'package:genix/features/video%20shorts%20screen/video_shorts_router.dart';
import 'package:genix/features/videos%20page/videosscreen.dart';
import 'package:go_router/go_router.dart';

abstract class Rout {
  static const kRegister = '/register';
  static const kGlb = '/glb';

  static const kReplies = '/replies';
  static const kPhotosScreen = '/photos';
  static const kVideosScreen = '/videos';
  static const kGroupsScreen = '/groups';
  static const kPagesScreen = '/pages';
  static const kChatsListing = '/chat-listing';
  static const kChatScreen = '/chat';

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
      path: kPhotosScreen,
      builder: (context, state) => const PhotosScreen(),
    ),
    GoRoute(
      path: kVideosScreen,
      builder: (context, state) => const VideosScreen(),
    ),
    GoRoute(
      path: kGroupsScreen,
      builder: (context, state) => const GroupsScreen(),
    ),
    GoRoute(
      path: kPagesScreen,
      builder: (context, state) => const PagesScreen(),
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
    ...VideoShortsRouter.goRoutes,
    ...CommentsRouter.goRoutes,
    ...HomeRouter.goRoutes,
    ...LockRouter.goRoutes,
    ...SearchRouter.goRoutes,
    ...ProfileRouter.goRoutes,
    ...NotificationsRouter.goRoutes,
    ...FollowingsRouter.goRoutes,
    ...FollowersRouter.goRoutes,
    ...SettingRouter.goRoutes,
    ...SupportTicketsRouter.goRoutes,
    ...LoginRouter.goRoutes,
    ...MyProfileRouter.goRoutes,
  ]);
}
