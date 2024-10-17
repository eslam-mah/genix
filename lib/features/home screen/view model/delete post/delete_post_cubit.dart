import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'delete_post_state.dart';

class DeletePostCubit extends Cubit<DeletePostState> {
  DeletePostCubit() : super(DeletePostInitial());
  final PostsRepository deletePostRepo = PostsRepository();
  Future<void> deletePost({required int postId}) async {
    emit(DeletePostLoading());
    final result = await deletePostRepo.deletePost(postId: postId);
    result.fold(
        (l) => emit(DeletePostError()),
        (r) => emit(DeletePostSuccess(
            message: 'Post Deleted successfully', id: postId)));
  }
}
