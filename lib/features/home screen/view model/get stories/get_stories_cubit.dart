import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_list.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'get_stories_state.dart';

class GetStoriesCubit extends Cubit<GetStoriesState> {
  GetStoriesCubit() : super(GetStoriesInitial());
  final PostsRepository getStoriesRepo = PostsRepository();
  Future<void> getStories() async {
    emit(GetStoriesLoading());
    final result = await getStoriesRepo.getStories();
    result.fold((l) {
      emit(GetStoriesError());
    }, (r) {
      final stories = PostsList.fromJson(r as Map<String, dynamic>);
      emit(GetStoriesSuccess(stories: stories));
    });
  }
}
