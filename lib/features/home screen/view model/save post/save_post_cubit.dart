import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/post_form.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/data.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'save_post_state.dart';

class SavePostCubit extends Cubit<SavePostState> {
  SavePostCubit() : super(SavePostInitial());
  final PostsRepository savePostRepo = PostsRepository();
  Future<void> savePost({required PostForm data, required int postId}) async {
    emit(SavePostLoading());
    final result =
        await savePostRepo.savePost(data: data.toJson(), postId: postId);
    result.fold((l) => emit(SavePostError()), (r) {
      final post = PostForm.fromJson(data.toJson());
      SavePostSuccess(post: post);
    });
  }
}
