part of 'restrict_user_cubit.dart';

@immutable
sealed class RestrictUserState extends Equatable {
  const RestrictUserState();

  @override
  List<Object> get props => [];
}

final class RestrictUserInitial extends RestrictUserState {}

final class RestrictUserLoading extends RestrictUserState {}

final class RestrictUserSuccess extends RestrictUserState {
  final UserModel restrictedUser;
  const RestrictUserSuccess({required this.restrictedUser});
}

final class RestrictUserError extends RestrictUserState {}
