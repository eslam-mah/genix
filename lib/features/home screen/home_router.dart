import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/home%20screen/view%20model/add%20donation%20post/add_donation_post_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/add%20poll%20post/add_poll_post_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/add%20post/add_post_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/add%20react/add_react_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/delete%20post/delete_post_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/get%20live%20channel/get_live_channel_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/get%20newsfeed%20posts/get_newsfeed_posts_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/get%20photo%20posts/get_photo_posts_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/get%20post%20by%20id/get_post_by_id_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/get%20reactions/get_reactions_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/get%20stories/get_stories_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/get%20timeline%20posts/get_timeline_posts_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/get%20video%20posts/get_video_posts_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/post%20report/post_report_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/save%20post/save_post_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/share%20post/share_post_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/update%20post%20by%20id/update_post_by_id_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/view%20post/view_post_cubit.dart';
import 'package:genix/features/home%20screen/views/view/homebody.dart';
import 'package:genix/features/users/view%20model/delete%20user/delete_user_cubit.dart';
import 'package:go_router/go_router.dart';

abstract class HomeRouter {
  static final addDonationCubit = AddDonationPostCubit();
  static final addPollPostCubit = AddPollPostCubit();
  static final addPostCubit = AddPostCubit();
  static final addReactCubit = AddReactCubit();
  static final deletePostCubit = DeletePostCubit();
  static final deleteUserPostCubit = DeleteUserCubit();
  static final getLiveChannelCubit = GetLiveChannelCubit();
  static final getNewsFeedPostsCubit = GetNewsFeedPostsCubit();
  static final getPhotoPostsCubit = GetPhotoPostsCubit();
  static final getPostByIdCubit = GetPostByIdCubit();
  static final getReactionsCubit = GetReactionsCubit();
  static final getStoriesCubit = GetStoriesCubit();
  static final getTimeLinePostsCubit = GetTimelinePostsCubit();
  static final getVideoPostsCubit = GetVideoPostsCubit();
  static final savePostCubit = SavePostCubit();
  static final addReportCubit = PostReportCubit();
  static final sharePostCubit = SharePostCubit();
  static final updatePostByIdCubit = UpdatePostByIdCubit();
  static final viewPostCubit = ViewPostCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: HomePage.routeName,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: addDonationCubit,
              ),
              BlocProvider.value(
                value: addPollPostCubit,
              ),
              BlocProvider.value(
                value: addReactCubit,
              ),
              BlocProvider.value(
                value: addPostCubit,
              ),
              BlocProvider.value(
                value: deletePostCubit,
              ),
              BlocProvider.value(
                value: deleteUserPostCubit,
              ),
              BlocProvider.value(
                value: getLiveChannelCubit,
              ),
              BlocProvider.value(
                value: getNewsFeedPostsCubit,
              ),
              BlocProvider.value(
                value: getPhotoPostsCubit,
              ),
              BlocProvider.value(
                value: getPostByIdCubit,
              ),
              BlocProvider.value(
                value: getReactionsCubit,
              ),
              BlocProvider.value(
                value: getStoriesCubit,
              ),
              BlocProvider.value(
                value: getTimeLinePostsCubit,
              ),
              BlocProvider.value(
                value: getVideoPostsCubit,
              ),
              BlocProvider.value(
                value: savePostCubit,
              ),
              BlocProvider.value(
                value: addReportCubit,
              ),
              BlocProvider.value(
                value: sharePostCubit,
              ),
              BlocProvider.value(
                value: updatePostByIdCubit,
              ),
              BlocProvider.value(
                value: viewPostCubit,
              ),
            ],
            child: HomePage(homePageArgs: state.extra as HomePageArgs),
          );
        }),
  ];
}
