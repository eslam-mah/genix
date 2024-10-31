import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/payments/view_model/create_stripe/create_stripe_cubit.dart';

import 'package:genix/features/payments/views/view/payment_stripe_screen.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:go_router/go_router.dart';

abstract class PaymentRouter {
  static final getAccountDetails = GetMyAccountDetailsCubit();
  static final createStripeCubit = CreateStripeCubit();
  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: PaymentStripeScreen.routeName,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getAccountDetails,
              ),
              BlocProvider.value(
                value: createStripeCubit,
              ),
            ],
            child: PaymentStripeScreen(
              amount: state.extra as num,
            ),
          );
        }),
  ];
}
