import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/followers%20list%20page/view%20model/get%20followers/get_followers_cubit.dart';
import 'package:genix/features/followers%20list%20page/views/view/followers_page.dart';
import 'package:go_router/go_router.dart';

abstract class FollowersRouter {
  static final getFollowersCubit = GetFollowersCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: FollowersPage.route,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getFollowersCubit,
              ),
            ],
            child: FollowersPage(args: state.extra as FollowersPageArgs),
          );
        }),
  ];
}
