import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/pages%20screen/data/repos/pages_repository.dart';

part 'delete_page_member_comment_state.dart';

class DeletePageMemberCommentCubit extends Cubit<DeletePageMemberCommentState> {
  DeletePageMemberCommentCubit() : super(DeletePageMemberCommentInitial());
  final PagesRepository pagesRepository = PagesRepository();
  Future<void> deletePageMemberComment({required int id}) async {
    emit(DeletePageMemberCommentLoading());
    final result = await pagesRepository.deletePageMemberComment(id: id);
    result.fold((l) => emit(DeletePageMemberCommentError()), (r) {
      emit(DeletePageMemberCommentSuccess(id: id));
    });
  }
}
