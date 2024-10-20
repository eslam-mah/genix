part of 'get_group_members_cubit.dart';

sealed class GetGroupMembersState extends Equatable {
  const GetGroupMembersState();

  @override
  List<Object> get props => [];
}

final class GetGroupMembersInitial extends GetGroupMembersState {}

final class GetGroupMembersLoading extends GetGroupMembersState {}

final class GetGroupMembersSuccess extends GetGroupMembersState {
  final GroupProfileModel group;

  const GetGroupMembersSuccess({required this.group});
}

final class GetGroupMembersError extends GetGroupMembersState {}
