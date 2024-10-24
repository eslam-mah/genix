part of 'get_group_members_cubit.dart';

sealed class GetGroupMembersState extends Equatable {
  const GetGroupMembersState();

  @override
  List<Object> get props => [];
}

final class GetGroupMembersInitial extends GetGroupMembersState {}

final class GetGroupMembersLoading extends GetGroupMembersState {}

final class GetGroupMembersSuccess extends GetGroupMembersState {
  final MembersList member;

  const GetGroupMembersSuccess({required this.member});
}

final class GetGroupMembersError extends GetGroupMembersState {}
