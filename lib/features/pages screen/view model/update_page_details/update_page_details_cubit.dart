import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/features/pages%20screen/data/repos/pages_repository.dart';

part 'update_page_details_state.dart';

class UpdatePageDetailsCubit extends Cubit<UpdatePageDetailsState> {
  UpdatePageDetailsCubit() : super(UpdatePageDetailsInitial());
  final PagesRepository updatePageDetails = PagesRepository();
  Future<void> updatePage({
    required String name,
    required String category,
    required String website,
    required String about,
    required String facebook,
    required String tiktok,
    required String x,
    required bool isPrivate,
    required String instagram,
    required String pinterest,
    required String steam,
    required String linkedin,
    required int id,
    required File profileImg,
    required File coverImg,
  }) async {
    emit(UpdatePageDetailsLoading());
    final Either<FailureModel, Map> result =
        await updatePageDetails.updatePageDetails(
            isPrivate: isPrivate,
            name: name,
            category: category,
            website: website,
            id: id,
            about: about,
            facebook: facebook,
            tiktok: tiktok,
            x: x,
            instagram: instagram,
            pinterest: pinterest,
            steam: steam,
            linkedin: linkedin,
            profileImg: profileImg,
            coverImg: coverImg);

    result.fold(
      (failure) => emit(UpdatePageDetailsError()),
      (success) =>
          emit(UpdatePageDetailsSuccess(data: success as Map<String, dynamic>)),
    );
  }
}
