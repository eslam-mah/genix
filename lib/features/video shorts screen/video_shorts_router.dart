import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/comments%20section/view%20model/cubit/add_comment_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/add%20react/add_react_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/remove%20react/remove_react_cubit.dart';
import 'package:genix/features/home%20screen/view%20model/save%20post/save_post_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:genix/features/video%20shorts%20screen/view%20model/cubit/add_short_cubit.dart';
import 'package:genix/features/video%20shorts%20screen/view%20model/cubit/get_posted_shorts_cubit.dart';
import 'package:genix/features/video%20shorts%20screen/view%20model/cubit/get_saved_shorts_cubit.dart';
import 'package:genix/features/video%20shorts%20screen/view%20model/cubit/get_shorts_cubit.dart';
import 'package:genix/features/video%20shorts%20screen/view%20model/cubit/search_shorts_cubit.dart';
import 'package:genix/features/video%20shorts%20screen/view%20model/cubit/update_short_cubit.dart';
import 'package:genix/features/video%20shorts%20screen/views/view/video_shorts_body.dart';
import 'package:go_router/go_router.dart';

abstract class VideoShortsRouter {
  static final getShortsCubit = GetShortsCubit();
  static final addShortCubit = AddShortCubit();
  static final getPostedShortsCubit = GetPostedShortsCubit();
  static final searchShortsCubit = SearchShortsCubit();
  static final getSavedShortsCubit = GetSavedShortsCubit();
  static final updateShortsCubit = UpdateShortCubit();
  static final getAccountDetails = GetMyAccountDetailsCubit();

  static final addReactCubit = AddReactCubit();

  static final addCommentCubit = AddCommentCubit();

  static final savePostCubit = SavePostCubit();
  static final removeReactCubit = RemoveReactCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: VideoShortsBody.route,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getShortsCubit,
              ),
              BlocProvider.value(
                value: getPostedShortsCubit,
              ),
              BlocProvider.value(
                value: removeReactCubit,
              ),
              BlocProvider.value(
                value: getAccountDetails,
              ),
              BlocProvider.value(
                value: getSavedShortsCubit,
              ),
              BlocProvider.value(
                value: addShortCubit,
              ),
              BlocProvider.value(
                value: searchShortsCubit,
              ),
              BlocProvider.value(
                value: updateShortsCubit,
              ),
              BlocProvider.value(
                value: addCommentCubit,
              ),
              BlocProvider.value(
                value: addReactCubit,
              ),
              BlocProvider.value(
                value: savePostCubit,
              ),
            ],
            child: const VideoShortsBody(),
          );
        }),
  ];
}
