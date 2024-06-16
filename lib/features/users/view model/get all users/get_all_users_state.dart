part of 'get_all_users_cubit.dart';

@immutable
sealed class GetAllUsersState {}

final class GetAllUsersInitial extends GetAllUsersState {}

final class GetAllUsersLoading extends GetAllUsersState {}

final class GetAllUsersSuccess extends GetAllUsersState {
  final UserList users;
  GetAllUsersSuccess({required this.users});
}

final class GetAllUsersError extends GetAllUsersState {}
