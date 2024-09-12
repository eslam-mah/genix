part of 'add_comment_cubit.dart';

sealed class AddCommentState extends Equatable {
  const AddCommentState();

  @override
  List<Object> get props => [];
}

final class AddCommentInitial extends AddCommentState {}

final class AddCommentLoading extends AddCommentState {}

final class AddCommentSuccess extends AddCommentState {
  final Comment addComment;
  const AddCommentSuccess({required this.addComment});
}

final class AddCommentError extends AddCommentState {}
