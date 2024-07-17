part of 'update_post_by_id_cubit.dart';

sealed class UpdatePostByIdState extends Equatable {
  const UpdatePostByIdState();

  @override
  List<Object> get props => [];
}

final class UpdatePostByIdInitial extends UpdatePostByIdState {}

final class UpdatePostByIdLoading extends UpdatePostByIdState {}

final class UpdatePostByIdSuccess extends UpdatePostByIdState {
  final UpdatePostForm updatePost;
  const UpdatePostByIdSuccess({required this.updatePost});
}

final class UpdatePostByIdError extends UpdatePostByIdState {}
