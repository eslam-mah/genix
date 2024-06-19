part of 'update_user_details_cubit.dart';

@immutable
sealed class UpdateUserDetailsState extends Equatable {
  const UpdateUserDetailsState();

  @override
  List<Object> get props => [];
}

final class UpdateUserDetailsInitial extends UpdateUserDetailsState {}

final class UpdateUserDetailsLoading extends UpdateUserDetailsState {}

final class UpdateUserDetailsSuccess extends UpdateUserDetailsState {
  final UserForm updateUser;
  const UpdateUserDetailsSuccess({required this.updateUser});
}

final class UpdateUserDetailsError extends UpdateUserDetailsState {}
