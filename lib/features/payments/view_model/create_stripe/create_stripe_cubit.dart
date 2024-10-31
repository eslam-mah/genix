import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/payments/data/models/stripe_form.dart';
import 'package:genix/features/payments/data/repos/stripe_repo.dart';

part 'create_stripe_state.dart';

class CreateStripeCubit extends Cubit<CreateStripeState> {
  CreateStripeCubit() : super(CreateStripeInitial());
  final StripeRepo paymentRepository = StripeRepo();
  Future<void> createStripe({required StripeForm data}) async {
    emit(CreateStripeLoading());
    final result = await paymentRepository.createStripe(data: data.toJson());

    result.fold(
      (failure) => emit(CreateStripeError(error: failure.message ?? 'error')),
      (clientSecret) => emit(CreateStripeSuccess(clientSecret: clientSecret)),
    );
  }
}
