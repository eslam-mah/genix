import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/followers%20list%20page/view%20model/get%20followers/get_followers_cubit.dart';
import 'package:genix/features/followers%20list%20page/views/view/followers_page.dart';
import 'package:genix/features/followers%20list%20page/views/view/my_followers_page.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:go_router/go_router.dart';

abstract class FollowersRouter {
  static final getFollowersCubit = GetFollowersCubit();
  static final getMyAccountDetailsCubit = GetMyAccountDetailsCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: FollowersPage.route,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getFollowersCubit,
              ),
              BlocProvider.value(
                value: getMyAccountDetailsCubit,
              ),
            ],
            child: FollowersPage(id: state.extra as int),
          );
        }),
  ];
}
