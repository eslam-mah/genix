import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/login%20screen/view_model/log_in_cubit/log_in_cubit.dart';
import 'package:genix/features/login%20screen/views/view/log_in_screen.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:genix/features/splash%20screen/view%20model/first%20load/first_load_cubit.dart';
import 'package:go_router/go_router.dart';

abstract class LoginRouter {
  static final logInCubit = LogInCubit();
  static final getMyAccount = FirstLoadCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: LoginScreen.route,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: logInCubit,
              ),
              BlocProvider.value(
                value: getMyAccount,
              ),
            ],
            child: LoginScreenBody(args: state.extra as LogInScreenArgs),
          );
        })
  ];
}
