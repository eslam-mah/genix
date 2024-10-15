part of 'delete_page_member_comment_cubit.dart';

sealed class DeletePageMemberCommentState extends Equatable {
  const DeletePageMemberCommentState();

  @override
  List<Object> get props => [];
}

final class DeletePageMemberCommentInitial
    extends DeletePageMemberCommentState {}

final class DeletePageMemberCommentLoading
    extends DeletePageMemberCommentState {}

final class DeletePageMemberCommentSuccess
    extends DeletePageMemberCommentState {
  final int id;

  const DeletePageMemberCommentSuccess({required this.id});
}

final class DeletePageMemberCommentError extends DeletePageMemberCommentState {}
