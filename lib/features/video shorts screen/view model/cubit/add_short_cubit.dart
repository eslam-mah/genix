import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/features/video%20shorts%20screen/data/models/shorts_model.dart';
import 'package:genix/features/video%20shorts%20screen/data/repos/shorts_repository.dart';

part 'add_short_state.dart';

class AddShortCubit extends Cubit<AddShortState> {
  AddShortCubit() : super(AddShortInitial());
  final ShortsRepository addShortRepo = ShortsRepository();
  // Function to update profile image and cover image

  Future<void> addShort({required File video, required String content}) async {
    emit(AddShortLoading()); // Emit loading state

    // Call the repository to update the profile
    Either<FailureModel, Map> result = await addShortRepo.addShort(
      file: video,
      content: content,
    );

    // Handle the result
    result.fold(
      (failure) => emit(
          AddShortError(message: failure.message ?? '')), // Emit failure state
      (data) => emit(AddShortSuccess(
          short: ShortsModel.fromJson(
              data as Map<String, dynamic>))), // Emit success state
    );
  }
}
