part of 'update_notification_cubit.dart';

sealed class UpdateNotificationState extends Equatable {
  const UpdateNotificationState();

  @override
  List<Object> get props => [];
}

final class UpdateNotificationInitial extends UpdateNotificationState {}

final class UpdateNotificationLoading extends UpdateNotificationState {}

final class UpdateNotificationSuccess extends UpdateNotificationState {
  final NotificationsModel notification;
  const UpdateNotificationSuccess({required this.notification});
}

final class UpdateNotificationError extends UpdateNotificationState {}
