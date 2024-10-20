import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/settings%20screen/data/models/payout_model.dart';
import 'package:genix/features/settings%20screen/data/repos/setting_repository.dart';

part 'post_payout_state.dart';

class PostPayoutCubit extends Cubit<PostPayoutState> {
  PostPayoutCubit() : super(PostPayoutInitial());
  final SettingRepository postPayoutsRepo = SettingRepository();
  Future<void> postPayout({required PayoutModel data}) async {
    emit(PostPayoutLoading());
    final result = await postPayoutsRepo.postPayout(data: data.toJson());
    result.fold((l) => emit(PostPayoutError()), (r) {
      final payout = PayoutModel.fromJson(data.toJson());
      emit(PostPayoutSuccess(payout: payout));
    });
  }
}
