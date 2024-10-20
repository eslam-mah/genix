part of 'delete_group_member_post_cubit.dart';

sealed class DeleteGroupMemberPostState extends Equatable {
  const DeleteGroupMemberPostState();

  @override
  List<Object> get props => [];
}

final class DeleteGroupMemberPostInitial extends DeleteGroupMemberPostState {}

final class DeleteGroupMemberPostLoading extends DeleteGroupMemberPostState {}

final class DeleteGroupMemberPostSuccess extends DeleteGroupMemberPostState {
  final int postId;

  const DeleteGroupMemberPostSuccess({required this.postId});
}

final class DeleteGroupMemberPostError extends DeleteGroupMemberPostState {}
