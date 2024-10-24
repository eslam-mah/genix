import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/settings%20screen/data/repos/setting_repository.dart';

part 'update_my_emails_state.dart';

class UpdateMyEmailsCubit extends Cubit<UpdateMyEmailsState> {
  UpdateMyEmailsCubit() : super(UpdateMyEmailsInitial());
  final SettingRepository updateMyEmailsRepo = SettingRepository();

  Future<void> updateMyEmails({required bool allowEmails}) async {
    emit(UpdateMyEmailsLoading());

    // Pass the `allowEmails` parameter to the repository
    final result = await updateMyEmailsRepo.updateMyEmails(
      data: {'allow_emails': allowEmails}, // Sending the value to the backend
    );

    result.fold(
      (l) => emit(UpdateMyEmailsError()),
      (r) => emit(
          const UpdateMyEmailsSuccess(setting: 'Setting updated successfully')),
    );
  }
}
