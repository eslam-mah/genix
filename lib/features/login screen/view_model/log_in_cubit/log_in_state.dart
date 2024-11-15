part of 'log_in_cubit.dart';

@immutable
sealed class LogInState extends Equatable {
  const LogInState();

  @override
  List<Object> get props => [];
}

final class LogInInitial extends LogInState {}

final class LogInLoading extends LogInState {}

final class LogInSuccess extends LogInState {
  final Map<dynamic, dynamic> data;

  const LogInSuccess({required this.data});
}

final class LogInError extends LogInState {
  final String message;

  const LogInError({required this.message});
}
