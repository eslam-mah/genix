import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/story%20screen/data/repos/story_repository.dart';

part 'add_story_react_state.dart';

class AddStoryReactCubit extends Cubit<AddStoryReactState> {
  AddStoryReactCubit() : super(AddStoryReactInitial());
  final StoryRepository addStoryReactionsRepo = StoryRepository();

  Future<void> addStoryReactions(
      {required String reactionType, required int postId}) async {
    emit(AddStoryReactLoading());

    final Map<String, dynamic> data = {'type': reactionType};

    final result =
        await addStoryReactionsRepo.addStoryReact(data: data, uploadId: postId);
    result.fold(
      (failure) => emit(AddStoryReactError()),
      (success) {
        final post = PostsModel.fromJson(success as Map<String, dynamic>);
        emit(AddStoryReactSuccess(reactionType: post));
      },
    );
  }
}
