part of 'update_my_profile_cubit.dart';

sealed class UpdateMyProfileState extends Equatable {
  const UpdateMyProfileState();

  @override
  List<Object> get props => [];
}

final class UpdateMyProfileInitial extends UpdateMyProfileState {}

final class UpdateMyProfileLoading extends UpdateMyProfileState {}

final class UpdateMyProfileSuccess extends UpdateMyProfileState {
  final String profile;
  const UpdateMyProfileSuccess({required this.profile});
}

final class UpdateMyProfileError extends UpdateMyProfileState {}
