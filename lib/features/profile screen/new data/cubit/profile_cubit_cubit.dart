import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:dartz/dartz.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/features/profile%20screen/new%20data/service.dart';

part 'profile_cubit_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileService _profileService = ProfileService();

  ProfileCubit() : super(ProfileInitial());

  Future<void> updateProfile({File? profileImg, File? coverImg}) async {
    emit(ProfileLoading());

    Either<FailureModel, Map> result = await _profileService.updateProfile(
      profileImg: profileImg,
      coverImg: coverImg,
    );

    result.fold(
      (failure) {
        emit(ProfileError(failure.message!));
      },
      (success) {
        // Safely access the user data by checking if it exists in the success map.
        final userData = success['data']?['user'];
        if (userData != null && userData is Map<String, dynamic>) {
          emit(ProfileSuccess(userData));
        } else {
          emit(ProfileError('User data not found or invalid.'));
        }
      },
    );
  }
}
