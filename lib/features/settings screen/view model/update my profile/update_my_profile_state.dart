part of 'update_my_profile_cubit.dart';

// Abstract base class for the profile states
abstract class UpdateMyProfileState extends Equatable {
  const UpdateMyProfileState();

  @override
  List<Object> get props => [];
}

// Initial state when nothing has happened
class UpdateProfileInitial extends UpdateMyProfileState {}

// State for when the profile is being updated (loading state)
class UpdateProfileLoading extends UpdateMyProfileState {}

// State for when the profile update succeeds
class UpdateProfileSuccess extends UpdateMyProfileState {
  final Map<String, dynamic> data;

  const UpdateProfileSuccess(this.data);

  @override
  List<Object> get props => [data];
}

// State for when the profile update fails
class UpdateProfileError extends UpdateMyProfileState {
  final String errorMessage;

  const UpdateProfileError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
