import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/groups%20page/data/repos/groups_repository.dart';

part 'post_group_invitation_state.dart';

class PostGroupInvitationCubit extends Cubit<PostGroupInvitationState> {
  PostGroupInvitationCubit() : super(PostGroupInvitationInitial());
  final GroupsRepository groupsRepository = GroupsRepository();
  Future<void> postGroupInvitation(
      {required Map<String, dynamic> data, required int id}) async {
    emit(PostGroupInvitationLoading());
    final result =
        await groupsRepository.postGroupInvitation(data: data, id: id);
    result.fold(
      (l) => emit(PostGroupInvitationError()),
      (r) {
        emit(const PostGroupInvitationSuccess(
            message: 'Group joined successfully'));
      },
    );
  }
}
