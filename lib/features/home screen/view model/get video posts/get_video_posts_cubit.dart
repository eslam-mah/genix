import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_list.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'get_video_posts_state.dart';

class GetVideoPostsCubit extends Cubit<GetVideoPostsState> {
  GetVideoPostsCubit() : super(GetVideoPostsInitial());
  final PostsRepository getVideoPostRepo = PostsRepository();
  Future<void> getVideoPost({required PostsModel uid}) async {
    emit(GetVideoPostsLoading());
    final result = await getVideoPostRepo.getVideoPosts(uid: uid.user!.id);
    result.fold((l) => emit(GetVideoPostsError()), (r) {
      final videoPosts = PostsList.fromJson(r as Map<String, dynamic>);
      GetVideoPostsSuccess(videoPosts: videoPosts);
    });
  }
}
