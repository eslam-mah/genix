import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/lock%20screen/view%20model/get%20lock/get_lock_cubit.dart';
import 'package:genix/features/lock%20screen/view%20model/post%20lock/post_lock_cubit.dart';
import 'package:genix/features/lock%20screen/view%20model/remove%20lock/remove_lock_cubit.dart';
import 'package:genix/features/lock%20screen/views/lock_page.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:go_router/go_router.dart';

abstract class LockRouter {
  static final getLockCubit = GetLockCubit();
  static final postLockCubit = PostLockCubit();
  static final removeLockCubit = RemoveLockCubit();
  static final getAccountDetails = GetMyAccountDetailsCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: LockPage.route,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getLockCubit,
              ),
              BlocProvider.value(
                value: postLockCubit,
              ),
              BlocProvider.value(
                value: getAccountDetails,
              ),
              BlocProvider.value(
                value: removeLockCubit,
              ),
            ],
            child: LockPage(args: state.extra as LockPageArgs),
          );
        }),
  ];
}
