import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/profile%20screen/view%20model/add%20friend/add_friend_cubit.dart';
import 'package:genix/features/profile%20screen/view%20model/get%20profile/get_profile_cubit.dart';
import 'package:genix/features/profile%20screen/view%20model/remove%20friend/remove_friend_cubit.dart';
import 'package:genix/features/profile%20screen/view%20model/update%20is%20close%20friend/is_close_friend_cubit.dart';
import 'package:genix/features/profile%20screen/views/view/profile_page.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:go_router/go_router.dart';

abstract class ProfileRouter {
  static final getProfileCubit = GetProfileCubit();
  static final addFriendCubit = AddFriendCubit();
  static final isCloseFriendCubit = IsCloseFriendCubit();
  static final removeFriendCubit = RemoveFriendCubit();
  static final getAccountDetails = GetMyAccountDetailsCubit();

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
              BlocProvider.value(
                value: getAccountDetails,
              ),
            ],
            child: ProfilePage(postsModel: state.extra as PostsModel),
          );
        }),
  ];
}
