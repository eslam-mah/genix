part of 'update_group_member_cubit.dart';

abstract class UpdateGroupMemberState extends Equatable {
  const UpdateGroupMemberState();

  @override
  List<Object> get props => [];
}

class UpdateGroupMemberInitial extends UpdateGroupMemberState {}

class UpdateGroupMemberLoading extends UpdateGroupMemberState {}

class UpdateGroupMemberSuccess extends UpdateGroupMemberState {
  final String message;

  UpdateGroupMemberSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class UpdateGroupMemberFailure extends UpdateGroupMemberState {
  final String errorMessage;

  UpdateGroupMemberFailure(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
