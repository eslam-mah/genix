part of 'create_stripe_cubit.dart';

abstract class CreateStripeState extends Equatable {
  const CreateStripeState();

  @override
  List<Object?> get props => [];
}

class CreateStripeInitial extends CreateStripeState {}

class CreateStripeLoading extends CreateStripeState {}

class CreateStripeSuccess extends CreateStripeState {
  final String clientSecret;

  const CreateStripeSuccess({required this.clientSecret});

  @override
  List<Object?> get props => [clientSecret];
}

class CreateStripeError extends CreateStripeState {
  final String error;

  const CreateStripeError({required this.error});

  @override
  List<Object?> get props => [error];
}
