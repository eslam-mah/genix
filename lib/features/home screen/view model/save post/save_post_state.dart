part of 'save_post_cubit.dart';

sealed class SavePostState extends Equatable {
  const SavePostState();

  @override
  List<Object> get props => [];
}

final class SavePostInitial extends SavePostState {}

final class SavePostLoading extends SavePostState {}

final class SavePostSuccess extends SavePostState {
  final PostForm post;
  const SavePostSuccess({required this.post});
}

final class SavePostError extends SavePostState {}
