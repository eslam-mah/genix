import 'package:genix/features/comments%20section/coments.dart';
import 'package:genix/features/comments%20section/replies.dart';
import 'package:genix/features/followers%20list%20page/followers_router.dart';
import 'package:genix/features/followings%20list%20page/followings_router.dart';
import 'package:genix/features/groups%20page/groupsscreen.dart';
import 'package:genix/features/home%20screen/home.dart';
import 'package:genix/features/login%20screen/login_router.dart';
import 'package:genix/features/my%20profile%20screen/myprofilescreen.dart';
import 'package:genix/features/notifications%20screen/notifications_router.dart';
import 'package:genix/features/pages%20list%20page/pagesscreen.dart';

import 'package:genix/features/photos%20page/photosscreen.dart';
import 'package:genix/features/register%20screen/register.dart';
import 'package:genix/features/settings%20screen/setting_router.dart';
import 'package:genix/features/splash%20screen/splashscreen.dart';
import 'package:genix/features/support%20tickets%20screen/support_tickets_router.dart';
import 'package:genix/features/video%20shorts%20screen/videoshorts.dart';
import 'package:genix/features/videos%20page/videosscreen.dart';
import 'package:go_router/go_router.dart';

abstract class Rout {
  static const kMyProfile = '/myprofile';
  static const kRegister = '/register';
  static const kHome = '/home';

  static const kGlb = '/glb';
  static const kComments = '/comments';
  static const kReplies = '/replies';
  static const kPhotosScreen = '/photos';
  static const kVideosScreen = '/videos';
  static const kGroupsScreen = '/groups';
  static const kPagesScreen = '/pages';

  static const kVideoShorts = '/videoShorts';
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
      path: kHome,
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: kComments,
      builder: (context, state) => const Comments(),
    ),
    GoRoute(
      path: kReplies,
      builder: (context, state) => const Replies(),
    ),
    GoRoute(
      path: kMyProfile,
      builder: (context, state) => const MyProfile(),
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
      path: kVideoShorts,
      builder: (context, state) => const VideoShorts(),
    ),
    ...NotificationsRouter.goRoutes,
    ...FollowingsRouter.goRoutes,
    ...FollowersRouter.goRoutes,
    ...SettingRouter.goRoutes,
    ...SupportTicketsRouter.goRoutes,
    ...LoginRouter.goRoutes,
  ]);
}
