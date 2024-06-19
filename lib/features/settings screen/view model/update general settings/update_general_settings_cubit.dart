import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/settings%20screen/data/models/settings_model.dart';
import 'package:genix/features/settings%20screen/data/repos/setting_repository.dart';

part 'update_general_settings_state.dart';

class UpdateGeneralSettingsCubit extends Cubit<UpdateGeneralSettingsState> {
  UpdateGeneralSettingsCubit() : super(UpdateGeneralSettingsInitial());
  final SettingRepository updateGeneralSettingsRepo = SettingRepository();
  Future<void> updateGeneralSettings({required SettingsModel data}) async {
    emit(UpdateGeneralSettingsLoading());
    final result = await updateGeneralSettingsRepo.updateGeneralSetting(
        data: data.toJson());
    result.fold((l) => emit(UpdateGeneralSettingsError()), (r) {
      final setting = SettingsModel.fromJson(data.toJson());
      emit(UpdateGeneralSettingsSuccess(setting: setting));
    });
  }
}
