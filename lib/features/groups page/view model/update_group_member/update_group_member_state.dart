part of 'update_group_member_cubit.dart';

sealed class UpdateGroupMemberState extends Equatable {
  const UpdateGroupMemberState();

  @override
  List<Object> get props => [];
}

final class UpdateGroupMemberInitial extends UpdateGroupMemberState {}

final class UpdateGroupMemberLoading extends UpdateGroupMemberState {}

final class UpdateGroupMemberSuccess extends UpdateGroupMemberState {
  final UpdateGroupMemberForm groupMember;
  const UpdateGroupMemberSuccess({required this.groupMember});
}

final class UpdateGroupMemberError extends UpdateGroupMemberState {}
