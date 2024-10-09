import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/groups%20page/data/repos/groups_repository.dart';

part 'update_group_invitation_state.dart';

class UpdateGroupInvitationCubit extends Cubit<UpdateGroupInvitationState> {
  UpdateGroupInvitationCubit() : super(UpdateGroupInvitationInitial());
  final GroupsRepository groupsRepository = GroupsRepository();
  Future<void> updateGroupInvitation(
      {required Map<String, dynamic> data, required int id}) async {
    emit(UpdateGroupInvitationLoading());
    final result = await groupsRepository.joinGroup(data: data, id: id);
    result.fold(
      (l) => emit(UpdateGroupInvitationError()),
      (r) {
        emit(const UpdateGroupInvitationSuccess('Group Invitation Updated'));
      },
    );
  }
}
