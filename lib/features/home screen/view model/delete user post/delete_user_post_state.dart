part of 'delete_user_post_cubit.dart';

sealed class DeleteUserPostState extends Equatable {
  const DeleteUserPostState();

  @override
  List<Object> get props => [];
}

final class DeleteUserPostInitial extends DeleteUserPostState {}

final class DeleteUserPostLoading extends DeleteUserPostState {}

final class DeleteUserPostSuccess extends DeleteUserPostState {
  final String message;

  const DeleteUserPostSuccess({required this.message});
}

final class DeleteUserPostError extends DeleteUserPostState {}
