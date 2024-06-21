import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/notifications%20screen/view%20model/get%20all%20notifications/get_all_notifications_cubit.dart';
import 'package:genix/features/notifications%20screen/view%20model/update%20notification/update_notification_cubit.dart';
import 'package:genix/features/notifications%20screen/views/view/notifications_page.dart';
import 'package:go_router/go_router.dart';

abstract class NotificationsRouter {
  static final getNotificationsCubit = GetAllNotificationsCubit();
  static final updateNotificationCubit = UpdateNotificationCubit();

  static final List<GoRoute> goRoutes = [
    GoRoute(
        path: NotificationsPage.route,
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider.value(
                value: getNotificationsCubit,
              ),
              BlocProvider.value(
                value: getNotificationsCubit,
              ),
            ],
            child:
                NotificationsPage(args: state.extra as NotificationsPageArgs),
          );
        }),
  ];
}
