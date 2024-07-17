import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_list.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'get_newsfeed_posts_state.dart';

class GetNewsFeedPostsCubit extends Cubit<GetNewsfeedPostsState> {
  GetNewsFeedPostsCubit() : super(GetNewsfeedPostsInitial());
  final PostsRepository getNewsFeedPostsRepo = PostsRepository();
  Future<void> getNewsFeedPosts() async {
    emit(GetNewsfeedPostsLoading());
    final result = await getNewsFeedPostsRepo.getNewsFeedPosts();
    result.fold((l) {
      emit(GetNewsfeedPostsError());
    }, (r) {
      final posts = PostsList.fromJson(r as Map<String, dynamic>);
      emit(GetNewsfeedPostsSuccess(posts: posts));
    });
  }
}
