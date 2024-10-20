part of 'update_group_details_cubit.dart';

sealed class UpdateGroupDetailsState extends Equatable {
  const UpdateGroupDetailsState();

  @override
  List<Object> get props => [];
}

final class UpdateGroupDetailsInitial extends UpdateGroupDetailsState {}

final class UpdateGroupDetailsLoading extends UpdateGroupDetailsState {}

final class UpdateGroupDetailsSuccess extends UpdateGroupDetailsState {
  final Map<String, dynamic> data;
  const UpdateGroupDetailsSuccess({required this.data});
}

final class UpdateGroupDetailsError extends UpdateGroupDetailsState {}
