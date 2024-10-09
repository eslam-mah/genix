import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:equatable/equatable.dart';
import 'dart:io';

import 'package:genix/features/settings%20screen/data/repos/setting_repository.dart';

// Define the states
part 'update_my_profile_state.dart';

class UpdateMyProfileCubit extends Cubit<UpdateMyProfileState> {
  final SettingRepository profileRepository = SettingRepository();

  UpdateMyProfileCubit() : super(UpdateProfileInitial());

  // Function to update profile image and cover image
  Future<void> updateProfile({File? profileImg, File? coverImg}) async {
    emit(UpdateProfileLoading()); // Emit loading state

    // Call the repository to update the profile
    Either<FailureModel, Map> result = await profileRepository.updateProfile(
      profileImg: profileImg,
      coverImg: coverImg,
    );

    // Handle the result
    result.fold(
      (failure) =>
          emit(UpdateProfileError(failure.message ?? '')), // Emit failure state
      (data) => emit(UpdateProfileSuccess(
          data as Map<String, dynamic>)), // Emit success state
    );
  }
}
