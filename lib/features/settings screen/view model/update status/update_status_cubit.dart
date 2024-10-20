import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/settings%20screen/data/models/settings_model.dart';
import 'package:genix/features/settings%20screen/data/repos/setting_repository.dart';

part 'update_status_state.dart';

class UpdateStatusCubit extends Cubit<UpdateStatusState> {
  UpdateStatusCubit() : super(UpdateStatusInitial());
  final SettingRepository updateStatusRepo = SettingRepository();
  Future<void> updateStatus({required SettingsModel data}) async {
    emit(UpdateStatusLoading());
    final result = await updateStatusRepo.updateStatus(data: data.toJson());
    result.fold((l) => emit(UpdateStatusError()), (r) {
      final status = SettingsModel.fromJson(data.toJson());
      emit(UpdateStatusSuccess(status: status));
    });
  }
}
