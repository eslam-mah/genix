import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/notifications%20screen/data/models/notifications_model.dart';
import 'package:genix/features/notifications%20screen/data/repos/notifications_repository.dart';

part 'update_notification_state.dart';

class UpdateNotificationCubit extends Cubit<UpdateNotificationState> {
  UpdateNotificationCubit() : super(UpdateNotificationInitial());
  final NotificationsRepository updateNotificationRepo =
      NotificationsRepository();
  Future<void> updateNotification(
      {required NotificationModel data, required NotificationModel id}) async {
    emit(UpdateNotificationLoading());
    final result = await updateNotificationRepo.updateNotification(
        data: data.toJson(), id: id.collection.first.id);
    result.fold((r) => emit(UpdateNotificationError()), (r) {
      final notification = NotificationModel.fromJson(data.toJson());
      emit(UpdateNotificationSuccess(notification: notification));
    });
  }
}
