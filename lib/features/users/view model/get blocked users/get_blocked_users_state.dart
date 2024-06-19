part of 'get_blocked_users_cubit.dart';

@immutable
sealed class GetBlockedUsersState extends Equatable {
  const GetBlockedUsersState();

  @override
  List<Object> get props => [];
}

final class GetBlockedUsersInitial extends GetBlockedUsersState {}

final class GetBlockedUsersLoading extends GetBlockedUsersState {}

final class GetBlockedUsersSuccess extends GetBlockedUsersState {
  final UserList users;
  const GetBlockedUsersSuccess({required this.users});
}

final class GetBlockedUsersError extends GetBlockedUsersState {}
