import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/settings%20screen/data/models/payout_model.dart';
import 'package:genix/features/settings%20screen/data/repos/setting_repository.dart';

part 'get_all_payouts_state.dart';

class GetAllPayoutsCubit extends Cubit<GetAllPayoutsState> {
  GetAllPayoutsCubit() : super(GetAllPayoutsInitial());
  final SettingRepository getPayoutsRepo = SettingRepository();
  Future<void> getPayout() async {
    emit(GetAllPayoutsLoading());
    final result = await getPayoutsRepo.getAllPayouts();
    result.fold((l) => emit(GetAllPayoutsError()), (r) {
      final payouts = PayoutModel.fromJson(r as Map<String, dynamic>);
      emit(GetAllPayoutsSuccess(payouts: payouts));
    });
  }
}
