import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/post_form.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostInitial());
  final PostsRepository addPostRepo = PostsRepository();

  Future<void> addPost({required PostForm data}) async {
    emit(AddPostLoading());
    try {
      final result = await addPostRepo.addPost(data: data.toJson());
      result.fold(
        (l) {
          // Log the error message
          print('Post failed with error: $l');
          emit(AddPostError());
        },
        (r) {
          final post = PostsModel.fromJson(data.toJson());
          emit(AddPostSuccess(post: post));
          print('posting successsssssssssssssssssssssssssssss');
        },
      );
    } catch (e) {
      // Catch any other exceptions and log them
      print('An exception occurred: $e');
      emit(AddPostError());
    }
  }
}
