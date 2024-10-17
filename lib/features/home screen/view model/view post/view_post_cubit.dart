import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/post_form.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/data.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'view_post_state.dart';

class ViewPostCubit extends Cubit<ViewPostState> {
  ViewPostCubit() : super(ViewPostInitial());
  final PostsRepository viewPostRepo = PostsRepository();
  Future<void> viewPost({required PostForm data, required int postId}) async {
    emit(ViewPostLoading());
    final result =
        await viewPostRepo.viewPost(data: data.toJson(), postId: postId);
    result.fold((l) => emit(ViewPostError()), (r) {
      final viewPost = PostForm.fromJson(data.toJson());
      ViewPostSuccess(viewPost: viewPost);
    });
  }
}
