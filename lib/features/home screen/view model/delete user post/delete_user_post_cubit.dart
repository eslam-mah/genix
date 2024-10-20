import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'delete_user_post_state.dart';

class DeleteUserPostCubit extends Cubit<DeleteUserPostState> {
  DeleteUserPostCubit() : super(DeleteUserPostInitial());
  final PostsRepository deleteUserPostRepository = PostsRepository();
  Future<void> deleteUserPost({required int postId}) async {
    emit(DeleteUserPostLoading());
    final result = await deleteUserPostRepository.deletePost(postId: postId);
    result.fold((l) {
      emit(DeleteUserPostError());
    }, (r) {
      emit(const DeleteUserPostSuccess(message: 'post deleted successfully'));
    });
  }
}
