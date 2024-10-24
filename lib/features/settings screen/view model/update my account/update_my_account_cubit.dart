import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/settings%20screen/data/repos/setting_repository.dart';

part 'update_my_account_state.dart';

class UpdateMyAccountCubit extends Cubit<UpdateMyAccountState> {
  UpdateMyAccountCubit() : super(UpdateMyAccountInitial());
  final SettingRepository updateMyAccountDetailsRepo = SettingRepository();
  Future<void> updateMyAccountDetails({
    String? showName,
    String? userName,
    String? email,
    String? bio,
    String? payPalEmail,
    String? facebook,
    String? x,
    String? instagram,
    String? tiktok,
    String? pinterest,
    String? steam,
    String? linkedIn,
    String? city,
    String? country,
    String? currentPassword,
    String? newPassword,
    String? gender,
    File? profileImg,
  }) async {
    emit(UpdateMyAccountLoading());
    final result = await updateMyAccountDetailsRepo.updateAccountDetails(
        showName: showName ?? "",
        userName: userName ?? 'a',
        email: email ?? '',
        bio: bio ?? '',
        city: city ?? 'a',
        country: country ?? 'a',
        currentPassword: currentPassword ?? '',
        newPassword: newPassword ?? '',
        payPalEmail: payPalEmail ?? '',
        facebook: facebook ?? '',
        tiktok: tiktok ?? '',
        instagram: instagram ?? '',
        x: x ?? '',
        pinterest: pinterest ?? '',
        steam: steam ?? '',
        linkedIn: linkedIn ?? '',
        profileImg: profileImg ?? File(''),
        gender: gender ?? 'male');
    result.fold((l) => emit(UpdateMyAccountError()), (r) {
      emit(UpdateMyAccountSuccess(setting: r as Map<String, dynamic>));
    });
  }
}
