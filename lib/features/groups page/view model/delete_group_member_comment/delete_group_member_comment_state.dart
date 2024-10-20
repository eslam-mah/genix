part of 'delete_group_member_comment_cubit.dart';

sealed class DeleteGroupMemberCommentState extends Equatable {
  const DeleteGroupMemberCommentState();

  @override
  List<Object> get props => [];
}

final class DeleteGroupMemberCommentInitial
    extends DeleteGroupMemberCommentState {}

final class DeleteGroupMemberCommentLoading
    extends DeleteGroupMemberCommentState {}

final class DeleteGroupMemberCommentSuccess
    extends DeleteGroupMemberCommentState {
  final int commentId;

  const DeleteGroupMemberCommentSuccess({required this.commentId});
}

final class DeleteGroupMemberCommentError
    extends DeleteGroupMemberCommentState {}
