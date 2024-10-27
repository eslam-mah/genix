import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'remove_react_state.dart';

class RemoveReactCubit extends Cubit<RemoveReactState> {
  RemoveReactCubit() : super(RemoveReactInitial());
  final PostsRepository deleteReactRepo = PostsRepository();

  Future<void> deleteReact({
    required int postId,
    required String reactionType,
  }) async {
    emit(RemoveReactLoading());

    // Send reaction type with the delete request
    final Map<String, dynamic> data = {'type': reactionType};

    final result =
        await deleteReactRepo.removeReact(postId: postId, data: data);
    result.fold(
      (failure) => emit(RemoveReactError()),
      (success) =>
          emit(const RemoveReactSuccess(message: 'React Deleted successfully')),
    );
  }
}
