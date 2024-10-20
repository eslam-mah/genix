import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/groups%20page/data/repos/groups_repository.dart';

part 'delete_group_member_post_state.dart';

class DeleteGroupMemberPostCubit extends Cubit<DeleteGroupMemberPostState> {
  DeleteGroupMemberPostCubit() : super(DeleteGroupMemberPostInitial());
  final GroupsRepository groupsRepository = GroupsRepository();
  Future<void> deleteGroupPost({required int id}) async {
    emit(DeleteGroupMemberPostLoading());
    final result = await groupsRepository.deleteGroupMemberPost(id: id);
    result.fold((l) => emit(DeleteGroupMemberPostError()), (r) {
      emit(DeleteGroupMemberPostSuccess(postId: id));
    });
  }
}
