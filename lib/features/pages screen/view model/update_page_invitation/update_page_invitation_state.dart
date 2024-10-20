part of 'update_page_invitation_cubit.dart';

sealed class UpdatePageInvitationState extends Equatable {
  const UpdatePageInvitationState();

  @override
  List<Object> get props => [];
}

final class UpdatePageInvitationInitial extends UpdatePageInvitationState {}

final class UpdatePageInvitationLoading extends UpdatePageInvitationState {}

final class UpdatePageInvitationSuccess extends UpdatePageInvitationState {
  final String message;

  const UpdatePageInvitationSuccess({required this.message});
}

final class UpdatePageInvitationError extends UpdatePageInvitationState {}
