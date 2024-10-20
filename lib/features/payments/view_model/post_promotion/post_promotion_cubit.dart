import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/payments/data/models/promotion_form.dart';
import 'package:genix/features/payments/data/repos/payment_repository.dart';

part 'post_promotion_state.dart';

class PostPromotionCubit extends Cubit<PostPromotionState> {
  PostPromotionCubit() : super(PostPromotionInitial());
  final PaymentRepository paymentRepository = PaymentRepository();

  Future<void> postPromotion({required PromotionForm data}) async {
    emit(PostPromotionLoading());
    final result = await paymentRepository.addPromotion(data: data.toJson());
    result.fold((l) => emit(PostPromotionError()), (r) {
      final promotion = PromotionForm.fromJson(data.toJson());
      emit(PostPromotionSuccess(promotion: promotion));
    });
  }
}
