part of 'log_in_cubit.dart';

@immutable
sealed class LogInState {}

final class LogInInitial extends LogInState {}

final class LogInLoading extends LogInState {}

final class LogInSuccess extends LogInState {
  final Map<dynamic, dynamic> data;

  LogInSuccess({required this.data});
}

final class LogInError extends LogInState {}
