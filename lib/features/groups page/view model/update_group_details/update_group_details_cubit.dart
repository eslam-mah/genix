import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/features/groups%20page/data/repos/groups_repository.dart';

part 'update_group_details_state.dart';

class UpdateGroupDetailsCubit extends Cubit<UpdateGroupDetailsState> {
  UpdateGroupDetailsCubit() : super(UpdateGroupDetailsInitial());
  final GroupsRepository updateGroupDetails = GroupsRepository();
  Future<void> updateGroup({
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
    emit(UpdateGroupDetailsLoading());
    final Either<FailureModel, Map> result =
        await updateGroupDetails.updateGroupDetails(
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
      (failure) => emit(UpdateGroupDetailsError()),
      (success) => emit(
          UpdateGroupDetailsSuccess(data: success as Map<String, dynamic>)),
    );
  }
}
