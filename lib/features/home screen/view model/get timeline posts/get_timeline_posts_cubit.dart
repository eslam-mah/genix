import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_list.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'get_timeline_posts_state.dart';

class GetTimelinePostsCubit extends Cubit<GetTimelinePostsState> {
  GetTimelinePostsCubit() : super(GetTimelinePostsInitial());
  final PostsRepository getTimeLinePostsRepo = PostsRepository();
  Future<void> getTimeLinePosts({required int uid, required int page}) async {
    emit(GetTimelinePostsLoading());
    final result =
        await getTimeLinePostsRepo.getTimelinePosts(uid: uid, page: page);
    result.fold((l) => emit(GetTimelinePostsError()), (r) {
      final posts = PostsList.fromJson(r as Map<String, dynamic>);
      GetTimelinePostsSuccess(posts: posts);
    });
  }
}
