import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/videos%20page/data/models/videos_list.dart';
import 'package:genix/features/videos%20page/data/repos/videos_repository.dart';

part 'get_video_posts_state.dart';

class GetVideoPostsCubit extends Cubit<GetVideoPostsState> {
  GetVideoPostsCubit() : super(GetVideoPostsInitial());
  final VideosRepository getVideoPostRepo = VideosRepository();
  Future<void> getVideoPost({required int uid}) async {
    emit(GetVideoPostsLoading());
    final result = await getVideoPostRepo.getVideoPosts(uid: uid);
    result.fold((l) => emit(GetVideoPostsError()), (r) {
      final videoPosts = VideosList.fromJson(r as Map<String, dynamic>);
      emit(GetVideoPostsSuccess(videoPosts: videoPosts));
    });
  }
}
