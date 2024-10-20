import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/payments/data/models/cpv_rate_model.dart';
import 'package:genix/features/payments/data/repos/payment_repository.dart';

part 'get_promotions_cpv_rate_state.dart';

class GetPromotionsCpvRateCubit extends Cubit<GetPromotionsCpvRateState> {
  GetPromotionsCpvRateCubit() : super(GetPromotionsCpvRateInitial());
  final PaymentRepository paymentRepository = PaymentRepository();
  Future<void> getCpvRate() async {
    emit(GetPromotionsCpvRateLoading());
    final result = await paymentRepository.getCpvRate();
    result.fold((l) => emit(GetPromotionsCpvRateError()), (r) {
      final cpvRate = CpvModel.fromJson(r as Map<String, dynamic>);
      emit(GetPromotionsCpvRateSuccess(cpvRate: cpvRate));
    });
  }
}
