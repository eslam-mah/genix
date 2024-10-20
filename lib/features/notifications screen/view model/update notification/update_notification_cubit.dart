import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/notifications%20screen/data/models/notifications_model.dart';
import 'package:genix/features/notifications%20screen/data/repos/notifications_repository.dart';

part 'update_notification_state.dart';

class UpdateNotificationCubit extends Cubit<UpdateNotificationState> {
  UpdateNotificationCubit() : super(UpdateNotificationInitial());
  final NotificationsRepository updateNotificationRepo =
      NotificationsRepository();
  Future<void> updateNotification(
      {required NotificationsModel data, required String id}) async {
    emit(UpdateNotificationLoading());
    final result = await updateNotificationRepo.updateNotification(
        data: data.toJson(), id: id);
    result.fold((r) => emit(UpdateNotificationError()), (r) {
      final notification = NotificationsModel.fromJson(data.toJson());
      emit(UpdateNotificationSuccess(notification: notification));
    });
  }
}
