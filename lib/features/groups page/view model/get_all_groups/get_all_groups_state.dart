part of 'get_all_groups_cubit.dart';

sealed class GetAllGroupsState extends Equatable {
  const GetAllGroupsState();

  @override
  List<Object> get props => [];
}

final class GetAllGroupsInitial extends GetAllGroupsState {}

final class GetAllGroupsLoading extends GetAllGroupsState {}

final class GetAllGroupsSuccess extends GetAllGroupsState {
  final GroupsList groups;

  const GetAllGroupsSuccess({required this.groups});
}

final class GetAllGroupsError extends GetAllGroupsState {}
