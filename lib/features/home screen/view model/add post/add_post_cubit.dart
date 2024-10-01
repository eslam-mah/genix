import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/core/services/failure_model.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/post_form.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostInitial());
  final PostsRepository addPostRepo = PostsRepository();

  // Unified function to handle both text and file posts
  Future<void> addPost({
    required PostForm data,
    List<File>? files, // Optional list of files
  }) async {
    emit(AddPostLoading());
    try {
      Either<FailureModel, Map>? result;

      if (files != null && files.isNotEmpty) {
        // If files exist, use the addFilePost method
        result = await addPostRepo.addFilePost(
          data: data.toJson(),
          files: files,
          name: 'files', // Adjust the field name according to your API
        );
      } else {
        // If no files, simply add a post with data
        result = await addPostRepo.addPost(data: data.toJson());
      }

      result.fold(
        (l) {
          // Log the error message
          print('Post failed with error: $l');
          emit(AddPostError());
        },
        (r) {
          final post = PostsModel.fromJson(data.toJson());
          emit(AddPostSuccess(post: post));
          print('Posting success!');
        },
      );
    } catch (e) {
      // Catch any other exceptions and log them
      print('An exception occurred: $e');
      emit(AddPostError());
    }
  }
}
