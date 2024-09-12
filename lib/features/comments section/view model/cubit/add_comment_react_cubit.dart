import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/comments%20section/data/repos/comments_repository.dart';

part 'add_comment_react_state.dart';

class AddCommentReactCubit extends Cubit<AddCommentReactState> {
  AddCommentReactCubit() : super(AddCommentReactInitial());
  final CommentsRepository addReactionComment = CommentsRepository();

  Future<void> addReactionsComment(
      {required String reactionType,
      required int postId,
      required int id}) async {
    emit(AddCommentReactLoading());

    final Map<String, dynamic> data = {'type': reactionType};

    final result = await addReactionComment.addCommentReact(
        data: data, postId: postId, id: id);
    result.fold(
      (failure) => emit(AddCommentReactError()),
      (success) => emit(AddCommentReactSuccess(commentReact: reactionType)),
    );
  }
}
