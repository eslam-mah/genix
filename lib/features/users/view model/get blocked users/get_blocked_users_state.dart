part of 'get_blocked_users_cubit.dart';

@immutable
sealed class GetBlockedUsersState {}

final class GetBlockedUsersInitial extends GetBlockedUsersState {}

final class GetBlockedUsersLoading extends GetBlockedUsersState {}

final class GetBlockedUsersSuccess extends GetBlockedUsersState {
  final UserList users;
  GetBlockedUsersSuccess({required this.users});
}

final class GetBlockedUsersError extends GetBlockedUsersState {}
