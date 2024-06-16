part of 'restrict_user_cubit.dart';

@immutable
sealed class RestrictUserState {}

final class RestrictUserInitial extends RestrictUserState {}

final class RestrictUserLoading extends RestrictUserState {}

final class RestrictUserSuccess extends RestrictUserState {
  final UserModel restrictedUser;
  RestrictUserSuccess({required this.restrictedUser});
}

final class RestrictUserError extends RestrictUserState {}
