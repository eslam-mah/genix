import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/groups%20page/data/repos/groups_repository.dart';

part 'remove_join_group_state.dart';

class RemoveJoinGroupCubit extends Cubit<RemoveJoinGroupState> {
  RemoveJoinGroupCubit() : super(RemoveJoinGroupInitial());
  final GroupsRepository groupsRepository = GroupsRepository();
  Future<void> removeJoinGroup({required int id}) async {
    emit(RemoveJoinGroupLoading());
    final result = await groupsRepository.removeJoinGroup(id: id);
    result.fold(
      (l) => emit(RemoveJoinGroupError()),
      (r) {
        emit(RemoveJoinGroupSuccess(groupId: id));
      },
    );
  }
}
