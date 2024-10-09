import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/profile%20screen/new%20data/cubit/profile_cubit_cubit.dart';
import 'package:genix/features/profile%20screen/view%20model/add%20friend/add_friend_cubit.dart';
import 'package:genix/features/profile%20screen/view%20model/get%20profile/get_profile_cubit.dart';
import 'package:genix/features/profile%20screen/view%20model/remove%20friend/remove_friend_cubit.dart';
import 'package:genix/features/profile%20screen/view%20model/update%20is%20close%20friend/is_close_friend_cubit.dart';
import 'package:genix/features/profile%20screen/views/view/my_profile_page.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/update%20my%20profile/update_my_profile_cubit.dart';

import 'package:go_router/go_router.dart';

abstract class MyProfileRouter {
  static final getProfileCubit = GetProfileCubit();
  static final addFriendCubit = AddFriendCubit();
  static final isCloseFriendCubit = IsCloseFriendCubit();
  static final removeFriendCubit = RemoveFriendCubit();
  static final getAccountDetails = GetMyAccountDetailsCubit();
  static final updateMyProfileAccount = UpdateMyProfileCubit();
  // static final updateMyProfileAccount = ProfileCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: MyProfilePage.route,
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
              BlocProvider.value(
                value: getAccountDetails,
              ),
              BlocProvider.value(
                value: updateMyProfileAccount,
              ),
            ],
            child: const MyProfilePage(),
          );
        }),
  ];
}
