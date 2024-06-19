part of 'get_my_restricted_users_cubit.dart';

@immutable
sealed class GetMyRestrictedUsersState extends Equatable {
  const GetMyRestrictedUsersState();

  @override
  List<Object> get props => [];
}

final class GetMyRestrictedUsersInitial extends GetMyRestrictedUsersState {}

final class GetMyRestrictedUsersLoading extends GetMyRestrictedUsersState {}

final class GetMyRestrictedUsersSuccess extends GetMyRestrictedUsersState {
  final UserList users;
  const GetMyRestrictedUsersSuccess({required this.users});
}

final class GetMyRestrictedUsersError extends GetMyRestrictedUsersState {}
