import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/groups%20page/data/models/update_group_memeber_form.dart';
import 'package:genix/features/groups%20page/data/repos/groups_repository.dart';

part 'update_group_member_state.dart';

class UpdateGroupMemberCubit extends Cubit<UpdateGroupMemberState> {
  UpdateGroupMemberCubit() : super(UpdateGroupMemberInitial());
  final GroupsRepository groupsRepository = GroupsRepository();
  Future<void> updateGroupMember(
      {required Map<String, dynamic> data, required int id}) async {
    emit(UpdateGroupMemberLoading());
    final result = await groupsRepository.updateGroupMember(data: data, id: id);
    result.fold(
      (l) => emit(UpdateGroupMemberError()),
      (r) {
        final updateGroupMember = UpdateGroupMemberForm.fromJson(data);
        emit(UpdateGroupMemberSuccess(groupMember: updateGroupMember));
      },
    );
  }
}
