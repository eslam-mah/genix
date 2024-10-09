import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/groups%20page/data/models/group_profile_model/group_profile_model.dart';
import 'package:genix/features/groups%20page/data/repos/groups_repository.dart';

part 'get_group_members_state.dart';

class GetGroupMembersCubit extends Cubit<GetGroupMembersState> {
  GetGroupMembersCubit() : super(GetGroupMembersInitial());
  final GroupsRepository groupsRepository = GroupsRepository();
  Future<void> getGroupMembers({required int id}) async {
    emit(GetGroupMembersLoading());
    final result = await groupsRepository.getGroupMembers(id: id);
    result.fold(
      (l) => emit(GetGroupMembersError()),
      (r) {
        final group = GroupProfileModel.fromJson(r as Map<String, dynamic>);
        emit(GetGroupMembersSuccess(group: group));
      },
    );
  }
}
