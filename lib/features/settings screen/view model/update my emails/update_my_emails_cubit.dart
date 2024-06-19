import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/settings%20screen/data/models/settings_model.dart';
import 'package:genix/features/settings%20screen/data/repos/setting_repository.dart';

part 'update_my_emails_state.dart';

class UpdateMyEmailsCubit extends Cubit<UpdateMyEmailsState> {
  UpdateMyEmailsCubit() : super(UpdateMyEmailsInitial());
  final SettingRepository updateMyEmailsRepo = SettingRepository();
  Future<void> updateMyEmails({required SettingsModel data}) async {
    emit(UpdateMyEmailsLoading());
    final result = await updateMyEmailsRepo.updateMyEmails(data: data.toJson());
    result.fold((l) => emit(UpdateMyEmailsError()), (r) {
      final setting = SettingsModel.fromJson(data.toJson());
      emit(UpdateMyEmailsSuccess(setting: setting));
    });
  }
}
