import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/settings%20screen/data/models/settings_model.dart';
import 'package:genix/features/settings%20screen/data/repos/setting_repository.dart';

part 'update_my_account_state.dart';

class UpdateMyAccountCubit extends Cubit<UpdateMyAccountState> {
  UpdateMyAccountCubit() : super(UpdateMyAccountInitial());
  final SettingRepository updateMyAccountDetailsRepo = SettingRepository();
  Future<void> updateMyAccountDetails({required SettingsModel data}) async {
    emit(UpdateMyAccountLoading());
    final result =
        await updateMyAccountDetailsRepo.updateMyAccount(data: data.toJson());
    result.fold((l) => emit(UpdateMyAccountError()), (r) {
      final setting = SettingsModel.fromJson(data.toJson());
      emit(UpdateMyAccountSuccess(setting: setting));
    });
  }
}
