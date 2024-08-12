import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/video%20shorts%20screen/view%20model/cubit/add_short_cubit.dart';
import 'package:genix/features/video%20shorts%20screen/view%20model/cubit/get_posted_shorts_cubit.dart';
import 'package:genix/features/video%20shorts%20screen/view%20model/cubit/get_saved_shorts_cubit.dart';
import 'package:genix/features/video%20shorts%20screen/view%20model/cubit/get_shorts_cubit.dart';
import 'package:genix/features/video%20shorts%20screen/view%20model/cubit/search_shorts_cubit.dart';
import 'package:genix/features/video%20shorts%20screen/view%20model/cubit/update_short_cubit.dart';
import 'package:genix/features/video%20shorts%20screen/views/videoshortsbody.dart';
import 'package:go_router/go_router.dart';

abstract class VideoShortsRouter {
  static final getShortsCubit = GetShortsCubit();
  static final addShortCubit = AddShortCubit();
  static final getPostedShortsCubit = GetPostedShortsCubit();
  static final searchShortsCubit = SearchShortsCubit();
  static final getSavedShortsCubit = GetSavedShortsCubit();
  static final updateShortsCubit = UpdateShortCubit();

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
            ],
            child: const VideoShortsBody(),
          );
        }),
  ];
}
