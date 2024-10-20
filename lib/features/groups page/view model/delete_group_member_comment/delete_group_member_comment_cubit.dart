import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/groups%20page/data/repos/groups_repository.dart';

part 'delete_group_member_comment_state.dart';

class DeleteGroupMemberCommentCubit
    extends Cubit<DeleteGroupMemberCommentState> {
  DeleteGroupMemberCommentCubit() : super(DeleteGroupMemberCommentInitial());
  final GroupsRepository groupsRepository = GroupsRepository();
  Future<void> deleteGroupMemberComment({required int id}) async {
    emit(DeleteGroupMemberCommentLoading());
    final result = await groupsRepository.deleteGroupMemberComment(id: id);
    result.fold((l) => emit(DeleteGroupMemberCommentError()), (r) {
      emit(DeleteGroupMemberCommentSuccess(commentId: id));
    });
  }
}
