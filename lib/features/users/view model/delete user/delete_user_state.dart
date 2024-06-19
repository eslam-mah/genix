part of 'delete_user_cubit.dart';

@immutable
sealed class DeleteUserState extends Equatable {
  const DeleteUserState();

  @override
  List<Object> get props => [];
}

final class DeleteUserInitial extends DeleteUserState {}

final class DeleteUserLoading extends DeleteUserState {}

final class DeleteUserSuccess extends DeleteUserState {
  final String user;
  const DeleteUserSuccess({required this.user});
}

final class DeleteUserError extends DeleteUserState {}
