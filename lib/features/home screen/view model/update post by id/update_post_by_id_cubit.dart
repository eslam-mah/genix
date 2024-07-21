import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/data.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/update_post_form.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'update_post_by_id_state.dart';

class UpdatePostByIdCubit extends Cubit<UpdatePostByIdState> {
  UpdatePostByIdCubit() : super(UpdatePostByIdInitial());
  final PostsRepository updatePostRepo = PostsRepository();
  Future<void> updatePost(
      {required UpdatePostForm data, required Data postId}) async {
    emit(UpdatePostByIdLoading());
    final result = await updatePostRepo.updatePostById(
        data: data.toJson(), postId: postId.collection!.first.id);
    result.fold((l) => emit(UpdatePostByIdError()), (r) {
      final updatePost = PostsModel.fromJson(data.toJson());
      UpdatePostByIdSuccess(updatePost: updatePost);
    });
  }
}
