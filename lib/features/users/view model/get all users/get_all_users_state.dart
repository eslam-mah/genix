part of 'get_all_users_cubit.dart';

@immutable
sealed class GetAllUsersState extends Equatable {
  const GetAllUsersState();

  @override
  List<Object> get props => [];
}

final class GetAllUsersInitial extends GetAllUsersState {}

final class GetAllUsersLoading extends GetAllUsersState {}

final class GetAllUsersSuccess extends GetAllUsersState {
  final UserList users;
  const GetAllUsersSuccess({required this.users});
}

final class GetAllUsersError extends GetAllUsersState {}
