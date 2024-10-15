part of 'update_page_profile_cubit.dart';

sealed class UpdatePageProfileState extends Equatable {
  const UpdatePageProfileState();

  @override
  List<Object> get props => [];
}

final class UpdatePageProfileInitial extends UpdatePageProfileState {}

final class UpdatePageProfileLoading extends UpdatePageProfileState {}

final class UpdatePageProfileSuccess extends UpdatePageProfileState {
  final Map<String, dynamic> data;

  const UpdatePageProfileSuccess({required this.data});
}

final class UpdatePageProfileError extends UpdatePageProfileState {}
