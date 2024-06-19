import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/settings%20screen/data/models/settings_model.dart';
import 'package:genix/features/settings%20screen/data/repos/setting_repository.dart';

part 'update_my_profile_state.dart';

class UpdateMyProfileCubit extends Cubit<UpdateMyProfileState> {
  UpdateMyProfileCubit() : super(UpdateMyProfileInitial());
  final SettingRepository updateFilesRepo = SettingRepository();
  Future<void> updateMyProfile(
      {required File profileImg, required File coverImg}) async {
    emit(UpdateMyProfileLoading());
    if (profileImg != null) {
      final result =
          await updateFilesRepo.updateProfile(profileImg, "profile_img");
      result.fold(
        (l) => emit(UpdateMyProfileError()),
        (r) {
          emit(UpdateMyProfileSuccess(profile: r['data']['profile_img']));
        },
      );
    }

    if (coverImg != null) {
      final result = await updateFilesRepo.updateProfile(coverImg, "cover_img");
      result.fold(
        (l) => emit(UpdateMyProfileError()),
        (r) {
          emit(UpdateMyProfileSuccess(profile: r['data']['cover_img']));
        },
      );
    }
  }
}
