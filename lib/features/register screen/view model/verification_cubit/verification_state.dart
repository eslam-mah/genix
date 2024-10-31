part of 'verification_cubit.dart';

sealed class VerificationState extends Equatable {
  const VerificationState();

  @override
  List<Object> get props => [];
}

final class VerificationInitial extends VerificationState {}

final class VerificationLoading extends VerificationState {}

final class VerificationSuccess extends VerificationState {
  final String message;

  const VerificationSuccess({required this.message});
  @override
  List<Object> get props => [message];
}

final class VerificationError extends VerificationState {}
