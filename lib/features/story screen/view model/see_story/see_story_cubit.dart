import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/story%20screen/data/models/story_model.dart';
import 'package:genix/features/story%20screen/data/repos/story_repository.dart';

part 'see_story_state.dart';

class SeeStoryCubit extends Cubit<SeeStoryState> {
  SeeStoryCubit() : super(SeeStoryInitial());
  final StoryRepository storyRepo = StoryRepository();
  Future<void> seeStory({required int id}) async {
    emit(SeeStoryLoading());
    final result = await storyRepo.seeStory(uploadId: id, {});
    result.fold((l) => emit(SeeStoryError()), (r) {
      final story = StoryModel.fromJson(r as Map<String, dynamic>);
      emit(SeeStorySuccess(storyModel: story));
    });
  }
}
