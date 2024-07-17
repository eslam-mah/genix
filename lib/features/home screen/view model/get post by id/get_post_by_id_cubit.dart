import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_list.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'get_post_by_id_state.dart';

class GetPostByIdCubit extends Cubit<GetPostByIdState> {
  GetPostByIdCubit() : super(GetPostByIdInitial());
  final PostsRepository getPostsByIdRepo = PostsRepository();
  Future<void> getPostById({required PostsModel postId}) async {
    emit(GetPostByIdLoading());
    final result =
        await getPostsByIdRepo.getPostById(postId: postId.collection!.first.id);
    result.fold((l) => emit(GetPostByIdError()), (r) {
      final posts = PostsList.fromJson(r as Map<String, dynamic>);
      emit(GetPostByIdSuccess(posts: posts));
    });
  }
}
