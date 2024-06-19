part of 'get_restricted_users_cubit.dart';

@immutable
sealed class GetRestrictedUsersState extends Equatable {
  const GetRestrictedUsersState();

  @override
  List<Object> get props => [];
}

final class GetRestrictedUsersInitial extends GetRestrictedUsersState {}

final class GetRestrictedUsersLoading extends GetRestrictedUsersState {}

final class GetRestrictedUsersSuccess extends GetRestrictedUsersState {
  final UserList users;
  const GetRestrictedUsersSuccess({required this.users});
}

final class GetRestrictedUsersError extends GetRestrictedUsersState {}
