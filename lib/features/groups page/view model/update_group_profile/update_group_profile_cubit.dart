import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/features/groups%20page/data/repos/groups_repository.dart';

part 'update_group_profile_state.dart';

class UpdateGroupProfileCubit extends Cubit<UpdateGroupProfileState> {
  UpdateGroupProfileCubit() : super(UpdateGroupProfileInitial());
  final GroupsRepository groupsRepository = GroupsRepository();
  Future<void> updateGroupProfile(
      {File? profileImg, File? coverImg, required int id}) async {
    emit(UpdateGroupProfileLoading()); // Emit loading state

    // Call the repository to update the profile
    Either<FailureModel, Map> result =
        await groupsRepository.updateGroupProfile(
      profileImg: profileImg,
      coverImg: coverImg,
      id: id,
    );

    // Handle the result
    result.fold(
      (l) => emit(UpdateGroupProfileError()), // Emit failure state
      (r) => emit(UpdateGroupProfileSuccess(
          data: r as Map<String, dynamic>)), // Emit success state
    );
  }
}
