import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/payments/data/repos/payment_repository.dart';

part 'create_stripe_state.dart';

class CreateStripeCubit extends Cubit<CreateStripeState> {
  CreateStripeCubit() : super(CreateStripeInitial());
  final PaymentRepository paymentRepository = PaymentRepository();
  Future<void> createStripe() async {
    emit(CreateStripeLoading());
    final result = await paymentRepository.createStripe(data: {});
    result.fold(
      (l) => emit(CreateStripeError()),
      (r) => emit(CreateStripeSuccess(message: 'created successfully')),
    );
  }
}
