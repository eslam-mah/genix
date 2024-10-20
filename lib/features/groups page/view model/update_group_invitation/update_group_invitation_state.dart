part of 'update_group_invitation_cubit.dart';

sealed class UpdateGroupInvitationState extends Equatable {
  const UpdateGroupInvitationState();

  @override
  List<Object> get props => [];
}

final class UpdateGroupInvitationInitial extends UpdateGroupInvitationState {}

final class UpdateGroupInvitationLoading extends UpdateGroupInvitationState {}

final class UpdateGroupInvitationSuccess extends UpdateGroupInvitationState {
  final String message;

  const UpdateGroupInvitationSuccess(this.message);
}

final class UpdateGroupInvitationError extends UpdateGroupInvitationState {}
