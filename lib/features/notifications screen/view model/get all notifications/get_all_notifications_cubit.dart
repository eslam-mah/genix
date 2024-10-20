import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/notifications%20screen/data/models/notifications_list.dart';
import 'package:genix/features/notifications%20screen/data/repos/notifications_repository.dart';

part 'get_all_notifications_state.dart';

class GetAllNotificationsCubit extends Cubit<GetAllNotificationsState> {
  GetAllNotificationsCubit() : super(GetAllNotificationsInitial());
  final NotificationsRepository getAllNotificationsRepo =
      NotificationsRepository();
  Future<void> getAllNotifications() async {
    emit(GetAllNotificationsLoading());
    final result = await getAllNotificationsRepo.getAllNotifications();
    result.fold((l) => emit(GetAllNotificationsError()), (r) {
      final notifications =
          NotificationsList.fromJson(r as Map<String, dynamic>);
      emit(GetAllNotificationsSuccess(notifications: notifications));
    });
  }
}
