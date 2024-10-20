part of 'remove_join_group_cubit.dart';

sealed class RemoveJoinGroupState extends Equatable {
  const RemoveJoinGroupState();

  @override
  List<Object> get props => [];
}

final class RemoveJoinGroupInitial extends RemoveJoinGroupState {}

final class RemoveJoinGroupLoading extends RemoveJoinGroupState {}

final class RemoveJoinGroupSuccess extends RemoveJoinGroupState {
  final int groupId;

  const RemoveJoinGroupSuccess({required this.groupId});
}

final class RemoveJoinGroupError extends RemoveJoinGroupState {}
