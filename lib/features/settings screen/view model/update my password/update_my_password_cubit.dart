import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/settings%20screen/data/models/security_form.dart';
import 'package:genix/features/settings%20screen/data/repos/setting_repository.dart';

part 'update_my_password_state.dart';

class UpdateMyPasswordCubit extends Cubit<UpdateMyPasswordState> {
  UpdateMyPasswordCubit() : super(UpdateMyPasswordInitial());
  final SettingRepository updateMyPasswordsRepo = SettingRepository();
  Future<void> updateMyPassword({required SecurityForm data}) async {
    emit(UpdateMyPasswordLoading());
    final result =
        await updateMyPasswordsRepo.updateMyPassword(data: data.toJson());
    result.fold((l) => emit(UpdateMyPasswordError()), (r) {
      final password = SecurityForm.fromJson(data.toJson());
      emit(UpdateMyPasswordSuccess(password: password));
    });
  }
}
