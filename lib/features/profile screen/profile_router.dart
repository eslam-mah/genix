import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/profile%20screen/view%20model/add%20friend/add_friend_cubit.dart';
import 'package:genix/features/profile%20screen/view%20model/get%20profile/get_profile_cubit.dart';
import 'package:genix/features/profile%20screen/view%20model/remove%20friend/remove_friend_cubit.dart';
import 'package:genix/features/profile%20screen/view%20model/update%20is%20close%20friend/is_close_friend_cubit.dart';
import 'package:genix/features/profile%20screen/views/view/profile_page.dart';
import 'package:go_router/go_router.dart';

abstract class ProfileRouter {
  static final getProfileCubit = GetProfileCubit();
  static final addFriendCubit = AddFriendCubit();
  static final isCloseFriendCubit = IsCloseFriendCubit();
  static final removeFriendCubit = RemoveFriendCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: ProfilePage.route,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getProfileCubit,
              ),
              BlocProvider.value(
                value: addFriendCubit,
              ),
              BlocProvider.value(
                value: removeFriendCubit,
              ),
              BlocProvider.value(
                value: isCloseFriendCubit,
              ),
            ],
            child: ProfilePage(args: state.extra as ProfilePageArgs),
          );
        }),
  ];
}
