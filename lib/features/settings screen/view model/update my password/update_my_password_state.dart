part of 'update_my_password_cubit.dart';

sealed class UpdateMyPasswordState extends Equatable {
  const UpdateMyPasswordState();

  @override
  List<Object> get props => [];
}

final class UpdateMyPasswordInitial extends UpdateMyPasswordState {}

final class UpdateMyPasswordLoading extends UpdateMyPasswordState {}

final class UpdateMyPasswordSuccess extends UpdateMyPasswordState {
  final SecurityForm password;
  const UpdateMyPasswordSuccess({required this.password});
}

final class UpdateMyPasswordError extends UpdateMyPasswordState {}
