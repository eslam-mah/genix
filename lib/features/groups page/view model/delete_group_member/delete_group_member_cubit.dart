import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/groups%20page/data/repos/groups_repository.dart';

part 'delete_group_member_state.dart';

class DeleteGroupMemberCubit extends Cubit<DeleteGroupMemberState> {
  DeleteGroupMemberCubit() : super(DeleteGroupMemberInitial());
  final GroupsRepository groupsRepository = GroupsRepository();
  Future<void> deleteGroupMember({required int id}) async {
    emit(DeleteGroupMemberLoading());
    final result = await groupsRepository.deleteGroupMember(id: id);
    result.fold((l) => emit(DeleteGroupMemberError()), (r) {
      emit(DeleteGroupMemberSuccess(memberId: id));
    });
  }
}
