import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/payments/data/models/promotions_model.dart';
import 'package:genix/features/payments/data/repos/payment_repository.dart';

part 'get_promotion_by_id_state.dart';

class GetPromotionByIdCubit extends Cubit<GetPromotionByIdState> {
  GetPromotionByIdCubit() : super(GetPromotionByIdInitial());
  final PaymentRepository paymentRepository = PaymentRepository();
  Future<void> getPromotionById() async {
    emit(GetPromotionByIdLoading());
    final result = await paymentRepository.getPromotions();
    result.fold((l) => emit(GetPromotionByIdError()), (r) {
      final promotions = PromotionsModel.fromJson(r as Map<String, dynamic>);
      emit(GetPromotionByIdSuccess(promotion: promotions));
    });
  }
}
