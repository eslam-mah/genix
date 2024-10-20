part of 'delete_group_cubit.dart';

sealed class DeleteGroupState extends Equatable {
  const DeleteGroupState();

  @override
  List<Object> get props => [];
}

final class DeleteGroupInitial extends DeleteGroupState {}

final class DeleteGroupLoading extends DeleteGroupState {}

final class DeleteGroupSuccess extends DeleteGroupState {
  final int groupId;

  const DeleteGroupSuccess({required this.groupId});
}

final class DeleteGroupError extends DeleteGroupState {}
