part of 'post_group_invitation_cubit.dart';

sealed class PostGroupInvitationState extends Equatable {
  const PostGroupInvitationState();

  @override
  List<Object> get props => [];
}

final class PostGroupInvitationInitial extends PostGroupInvitationState {}

final class PostGroupInvitationLoading extends PostGroupInvitationState {}

final class PostGroupInvitationSuccess extends PostGroupInvitationState {
  final String message;

  const PostGroupInvitationSuccess({required this.message});
}

final class PostGroupInvitationError extends PostGroupInvitationState {}
