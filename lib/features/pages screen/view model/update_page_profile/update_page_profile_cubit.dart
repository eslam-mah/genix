import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/features/pages%20screen/data/repos/pages_repository.dart';

part 'update_page_profile_state.dart';

class UpdatePageProfileCubit extends Cubit<UpdatePageProfileState> {
  UpdatePageProfileCubit() : super(UpdatePageProfileInitial());
  final PagesRepository pagesRepository = PagesRepository();
  Future<void> updateGroupProfile(
      {File? profileImg, File? coverImg, required int id}) async {
    emit(UpdatePageProfileLoading()); // Emit loading state

    // Call the repository to update the profile
    Either<FailureModel, Map> result = await pagesRepository.updatePageProfile(
      profileImg: profileImg,
      coverImg: coverImg,
      id: id,
    );

    // Handle the result
    result.fold(
      (l) => emit(UpdatePageProfileError()), // Emit failure state
      (r) => emit(UpdatePageProfileSuccess(
          data: r as Map<String, dynamic>)), // Emit success state
    );
  }
}
