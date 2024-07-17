import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/followings%20list%20page/view%20model/get%20followings/get_followings_cubit.dart';
import 'package:genix/features/followings%20list%20page/views/view/followings_page.dart';
import 'package:go_router/go_router.dart';

abstract class FollowingsRouter {
  static final getFollowingsCubit = GetFollowingsCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: FollowingsPage.route,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getFollowingsCubit,
              ),
            ],
            child: FollowingsPage(args: state.extra as FollowingsPageArgs),
          );
        }),
  ];
}
