import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/register%20screen/view%20model/register_cubit/register_cubit.dart';
import 'package:genix/features/register%20screen/view%20model/verification_cubit/verification_cubit.dart';
import 'package:genix/features/register%20screen/views/register_page.dart';
import 'package:genix/features/register%20screen/views/verification_screen.dart';
import 'package:genix/features/splash%20screen/view%20model/first%20load/first_load_cubit.dart';
import 'package:go_router/go_router.dart';

abstract class RegisterRouter {
  static final registerCubit = RegisterCubit();
  static final firstLoadCubit = FirstLoadCubit();
  static final verificationCubit = VerificationCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: RegisterBody.route,
        builder: (context, state) {
          return MultiBlocProvider(providers: [
            BlocProvider.value(
              value: registerCubit,
            )
          ], child: const RegisterBody());
        }),
    GoRoute(
        path: VerificationScreen.routeName,
        builder: (context, state) {
          return MultiBlocProvider(providers: [
            BlocProvider.value(
              value: registerCubit,
            ),
            BlocProvider.value(
              value: firstLoadCubit,
            ),
            BlocProvider.value(
              value: verificationCubit,
            ),
          ], child: const VerificationScreen());
        }),
  ];
}
