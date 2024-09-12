part of 'add_comment_react_cubit.dart';

sealed class AddCommentReactState extends Equatable {
  const AddCommentReactState();

  @override
  List<Object> get props => [];
}

final class AddCommentReactInitial extends AddCommentReactState {}

final class AddCommentReactLoading extends AddCommentReactState {}

final class AddCommentReactSuccess extends AddCommentReactState {
  final String commentReact;
  const AddCommentReactSuccess({required this.commentReact});
}

final class AddCommentReactError extends AddCommentReactState {}
