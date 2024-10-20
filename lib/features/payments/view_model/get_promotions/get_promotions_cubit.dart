import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/payments/data/models/promotions_list.dart';
import 'package:genix/features/payments/data/repos/payment_repository.dart';

part 'get_promotions_state.dart';

class GetPromotionsCubit extends Cubit<GetPromotionsState> {
  GetPromotionsCubit() : super(GetPromotionsInitial());
  final PaymentRepository paymentRepository = PaymentRepository();
  Future<void> getPromotions() async {
    emit(GetPromotionsLoading());
    final result = await paymentRepository.getPromotions();
    result.fold((l) => emit(GetPromotionsError()), (r) {
      final promotions = PromotionsList.fromJson(r as Map<String, dynamic>);
      emit(GetPromotionsSuccess(promotions: promotions));
    });
  }
}
