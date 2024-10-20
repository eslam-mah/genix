import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/followings%20list%20page/view%20model/get%20followings/get_followings_cubit.dart';
import 'package:genix/features/followings%20list%20page/views/view/followings_page.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:genix/features/videos%20page/view%20model/get%20video%20posts/get_video_posts_cubit.dart';
import 'package:genix/features/videos%20page/views/view/my_videos_page.dart';
import 'package:genix/features/videos%20page/views/view/videos_page.dart';
import 'package:go_router/go_router.dart';

abstract class VideosRouter {
  static final getVideosCubit = GetVideoPostsCubit();
  static final getMyAccountDetails = GetMyAccountDetailsCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: VideosPage.route,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getVideosCubit,
              ),
              BlocProvider.value(
                value: getMyAccountDetails,
              ),
            ],
            child: VideosPage(
              id: state.extra as int,
            ),
          );
        }),
  ];
}
