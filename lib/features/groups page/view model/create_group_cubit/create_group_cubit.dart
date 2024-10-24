import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/features/groups%20page/data/repos/groups_repository.dart';

part 'create_group_state.dart';

class CreateGroupCubit extends Cubit<CreateGroupState> {
  CreateGroupCubit() : super(CreateGroupInitial());
  final GroupsRepository createGroupRepo = GroupsRepository();
  Future<void> createGroup({
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
    required File profileImg,
    required File coverImg,
  }) async {
    emit(CreateGroupLoading());
    final Either<FailureModel, Map> result = await createGroupRepo.createGroup(
        name: name,
        category: category,
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
      (failure) => emit(CreateGroupError()),
      (success) =>
          emit(CreateGroupSuccess(data: success as Map<String, dynamic>)),
    );
  }
}
