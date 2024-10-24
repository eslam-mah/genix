import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';
part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostInitial());
  final PostsRepository addPostRepo = PostsRepository();
  Future<void> addPost({
    required String content,
    required String pageId,
    required String groupId,
    required String postingIn,
    required List<File> files,
    required String checkInLocation,
    required bool isLive,
    required bool cameraMirror,
    required String cameraId,
    required String deviceType,
    required String microphoneId,
    required bool checkIn,
    required bool toCloseFriends,
    required List<String> pollOptions,
    required bool poll,
    required String pollQuestion,
    required bool event,
    required String eventTimeStamp,
  }) async {
    emit(AddPostLoading());
    final Either<FailureModel, Map> result = await addPostRepo.addPost(
      content: content,
      pageId: pageId,
      groupId: groupId,
      postingIn: postingIn,
      files: files,
      checkInLocation: checkInLocation,
      isLive: isLive,
      cameraMirror: cameraMirror,
      cameraId: cameraId,
      deviceType: deviceType,
      microphoneId: microphoneId,
      checkIn: checkIn,
      toCloseFriends: toCloseFriends,
      pollOptions: pollOptions,
      poll: poll,
      pollQuestion: pollQuestion,
      event: event,
      eventTimeStamp: eventTimeStamp,
    );

    result.fold(
      (failure) => emit(AddPostFailure(failure.message ?? 'add post failure')),
      (success) => emit(AddPostSuccess(success as Map<String, dynamic>)),
    );
  }
}
