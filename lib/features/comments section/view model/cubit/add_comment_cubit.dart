import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/comments%20section/data/models/comments_model.dart';
import 'package:genix/features/comments%20section/data/repos/comments_repository.dart';

part 'add_comment_state.dart';

class AddCommentCubit extends Cubit<AddCommentState> {
  AddCommentCubit() : super(AddCommentInitial());
  final CommentsRepository addCommentssRepo = CommentsRepository();

  Future<void> addComments({required Comment comment}) async {
    emit(AddCommentLoading());

    final result = await addCommentssRepo.addComment(data: comment.toJson());
    result.fold(
      (failure) => emit(AddCommentError()),
      (success) => emit(AddCommentSuccess(addComment: comment)),
    );
  }
}
