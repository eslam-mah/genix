import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/features/pages%20screen/data/repos/pages_repository.dart';

part 'create_page_state.dart';

class CreatePageCubit extends Cubit<CreatePageState> {
  CreatePageCubit() : super(CreatePageInitial());
  final PagesRepository createPageRepo = PagesRepository();
  Future<void> createPage({
    required String name,
    required String category,
    required String website,
    required String about,
    required String facebook,
    required String tiktok,
    required String x,
    required String instagram,
    required String pinterest,
    required String steam,
    required String linkedin,
    required bool isPrivate,
    required File profileImg,
    required File coverImg,
  }) async {
    emit(CreatePageLoading());
    final Either<FailureModel, Map> result = await createPageRepo.createPage(
        name: name,
        category: category,
        isPrivate: isPrivate,
        website: website,
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
      (failure) => emit(CreatePageError()),
      (success) =>
          emit(CreatePageSuccess(data: success as Map<String, dynamic>)),
    );
  }
}
