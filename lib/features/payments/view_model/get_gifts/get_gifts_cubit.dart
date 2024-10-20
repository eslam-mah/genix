import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/payments/data/models/gifts_list.dart';
import 'package:genix/features/payments/data/repos/payment_repository.dart';

part 'get_gifts_state.dart';

class GetGiftsCubit extends Cubit<GetGiftsState> {
  GetGiftsCubit() : super(GetGiftsInitial());
  final PaymentRepository paymentRepository = PaymentRepository();
  Future<void> getGifts() async {
    emit(GetGiftsLoading());
    final result = await paymentRepository.getGifts();
    result.fold((l) => emit(GetGiftsError()), (r) {
      final gifts = GiftsList.fromJson(r as Map<String, dynamic>);
      emit(GetGiftsSuccess(gifts: gifts));
    });
  }
}
