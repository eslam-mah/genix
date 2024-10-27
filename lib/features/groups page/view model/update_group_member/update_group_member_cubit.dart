import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/groups%20page/data/models/update_group_memeber_form.dart';
import 'package:genix/features/groups%20page/data/repos/groups_repository.dart';

part 'update_group_member_state.dart';

class UpdateGroupMemberCubit extends Cubit<UpdateGroupMemberState> {
  // Inject the GroupsRepository in the constructor
  UpdateGroupMemberCubit() : super(UpdateGroupMemberInitial());
  final GroupsRepository groupsRepository = GroupsRepository();

  // Method to update the group member's roles and permissions
  Future<void> updateGroupMember({
    required Map<String, dynamic> updateGroupMemberForm,
    required int memberId,
  }) async {
    emit(UpdateGroupMemberLoading());

    // Convert the form into a JSON-friendly Map

    // Call the repository method to update the group member
    final result = await groupsRepository.updateGroupMember(
        data: updateGroupMemberForm, id: memberId);

    // Handle the result from the repository
    result.fold(
      (error) => emit(UpdateGroupMemberFailure(error.toString())),
      (success) {
        // Emit success state with the updated form
        emit(UpdateGroupMemberSuccess('member updated successfully'));
      },
    );
  }
}
