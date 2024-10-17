part of 'create_stripe_cubit.dart';

sealed class CreateStripeState extends Equatable {
  const CreateStripeState();

  @override
  List<Object> get props => [];
}

final class CreateStripeInitial extends CreateStripeState {}

final class CreateStripeLoading extends CreateStripeState {}

final class CreateStripeSuccess extends CreateStripeState {
  final String message;

  const CreateStripeSuccess({required this.message});
}

final class CreateStripeError extends CreateStripeState {}
