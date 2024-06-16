import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/login%20screen/view_model/log_in_cubit/log_in_cubit.dart';
import 'package:genix/features/login%20screen/views/view/log_in_screen.dart';
import 'package:go_router/go_router.dart';

abstract class LoginRouter {
  static final logInCubit = LogInCubit();
  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: LoginScreen.route,
        builder: (context, state) {
          return BlocProvider.value(
            value: logInCubit,
            child: LoginScreenBody(args: state.extra as LogInScreenArgs),
          );
        })
  ];
}
