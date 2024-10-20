part of 'create_group_cubit.dart';

sealed class CreateGroupState extends Equatable {
  const CreateGroupState();

  @override
  List<Object> get props => [];
}

final class CreateGroupInitial extends CreateGroupState {}

final class CreateGroupLoading extends CreateGroupState {}

final class CreateGroupSuccess extends CreateGroupState {
  final Map<String, dynamic> data;

  const CreateGroupSuccess({required this.data});
}

final class CreateGroupError extends CreateGroupState {}
