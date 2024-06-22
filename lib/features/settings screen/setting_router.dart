import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/settings%20screen/view%20model/delete%20my%20account/delete_my_account_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20all%20payouts/get_all_payouts_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20all%20transactions/get_all_transactions_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20my%20account%20details/get_my_account_details_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/post%20payout/post_payout_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/update%20general%20settings/update_general_settings_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/update%20my%20account/update_my_account_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/update%20my%20emails/update_my_emails_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/update%20my%20password/update_my_password_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/update%20my%20profile/update_my_profile_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/update%20status/update_status_cubit.dart';
import 'package:genix/features/settings%20screen/views/view/settings_page.dart';
import 'package:go_router/go_router.dart';

abstract class SettingRouter {
  static final getMyAccountDetailsCubit = GetMyAccountDetailsCubit();
  static final getAllTransactions = GetAllTransactionsCubit();
  static final getAllPayouts = GetAllPayoutsCubit();
  static final updateGeneralSettingsCubit = UpdateGeneralSettingsCubit();
  static final updateMyAccountCubit = UpdateMyAccountCubit();
  static final updateMyEmailsCubit = UpdateMyEmailsCubit();
  static final updateMyPasswordCubit = UpdateMyPasswordCubit();
  static final updateMyProfileCubit = UpdateMyProfileCubit();
  static final updateStatusCubit = UpdateStatusCubit();
  static final postPayoutCubit = PostPayoutCubit();
  static final deleteAccountCubit = DeleteMyAccountCubit();
  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: SettingsPage.route,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getMyAccountDetailsCubit,
              ),
              BlocProvider.value(
                value: getAllPayouts,
              ),
              BlocProvider.value(
                value: getAllTransactions,
              ),
              BlocProvider.value(
                value: updateGeneralSettingsCubit,
              ),
              BlocProvider.value(
                value: updateMyAccountCubit,
              ),
              BlocProvider.value(
                value: updateMyEmailsCubit,
              ),
              BlocProvider.value(
                value: updateMyPasswordCubit,
              ),
              BlocProvider.value(
                value: updateMyProfileCubit,
              ),
              BlocProvider.value(
                value: updateStatusCubit,
              ),
              BlocProvider.value(
                value: postPayoutCubit,
              ),
              BlocProvider.value(
                value: deleteAccountCubit,
              ),
            ],
            child: SettingsPage(args: state.extra as SettingsPageArgs),
          );
        }),
  ];
}
