part of 'get_group_by_id_cubit.dart';

sealed class GetGroupByIdState extends Equatable {
  const GetGroupByIdState();

  @override
  List<Object> get props => [];
}

final class GetGroupByIdInitial extends GetGroupByIdState {}

final class GetGroupByIdLoading extends GetGroupByIdState {}

final class GetGroupByIdSuccess extends GetGroupByIdState {
  final GroupProfileModel group;

  const GetGroupByIdSuccess({required this.group});
}

final class GetGroupByIdError extends GetGroupByIdState {}
