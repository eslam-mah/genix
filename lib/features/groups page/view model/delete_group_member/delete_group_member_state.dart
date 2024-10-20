part of 'delete_group_member_cubit.dart';

sealed class DeleteGroupMemberState extends Equatable {
  const DeleteGroupMemberState();

  @override
  List<Object> get props => [];
}

final class DeleteGroupMemberInitial extends DeleteGroupMemberState {}

final class DeleteGroupMemberLoading extends DeleteGroupMemberState {}

final class DeleteGroupMemberSuccess extends DeleteGroupMemberState {
  final int memberId;

  const DeleteGroupMemberSuccess({required this.memberId});
}

final class DeleteGroupMemberError extends DeleteGroupMemberState {}
