part of 'update_group_profile_cubit.dart';

sealed class UpdateGroupProfileState extends Equatable {
  const UpdateGroupProfileState();

  @override
  List<Object> get props => [];
}

final class UpdateGroupProfileInitial extends UpdateGroupProfileState {}

final class UpdateGroupProfileLoading extends UpdateGroupProfileState {}

final class UpdateGroupProfileSuccess extends UpdateGroupProfileState {
  final Map<String, dynamic> data;

  const UpdateGroupProfileSuccess({required this.data});
}

final class UpdateGroupProfileError extends UpdateGroupProfileState {}
