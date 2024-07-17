import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/post_form.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit() : super(AddPostInitial());
  final PostsRepository addPostRepo = PostsRepository();
  Future<void> addPost({required PostForm data}) async {
    emit(AddPostLoading());
    final result = await addPostRepo.addPost(data: data.toJson());
    result.fold((l) => emit(AddPostError()), (r) {
      final post = PostForm.fromJson(data.toJson());
      emit(AddPostSuccess(post: post));
    });
  }
}
