import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/followings%20list%20page/view%20model/get%20followings/get_followings_cubit.dart';
import 'package:genix/features/followings%20list%20page/views/view/followings_page.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:go_router/go_router.dart';

abstract class FollowingsRouter {
  static final getFollowingsCubit = GetFollowingsCubit();
  static final getAccountDetails = GetMyAccountDetailsCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: FollowingsPage.route,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getFollowingsCubit,
              ),
              BlocProvider.value(
                value: getAccountDetails,
              ),
            ],
            child: FollowingsPage(id: state.extra as int),
          );
        }),
  ];
}
