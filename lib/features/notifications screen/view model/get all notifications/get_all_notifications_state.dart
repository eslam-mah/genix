part of 'get_all_notifications_cubit.dart';

sealed class GetAllNotificationsState extends Equatable {
  const GetAllNotificationsState();

  @override
  List<Object> get props => [];
}

final class GetAllNotificationsInitial extends GetAllNotificationsState {}

final class GetAllNotificationsLoading extends GetAllNotificationsState {}

final class GetAllNotificationsSuccess extends GetAllNotificationsState {
  final NotificationsList notifications;
  const GetAllNotificationsSuccess({required this.notifications});
}

final class GetAllNotificationsError extends GetAllNotificationsState {}
