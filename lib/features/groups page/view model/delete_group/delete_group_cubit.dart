import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/groups%20page/data/repos/groups_repository.dart';

part 'delete_group_state.dart';

class DeleteGroupCubit extends Cubit<DeleteGroupState> {
  DeleteGroupCubit() : super(DeleteGroupInitial());
  final GroupsRepository groupsRepository = GroupsRepository();
  Future<void> deleteGroup({required int id}) async {
    emit(DeleteGroupLoading());
    final result = await groupsRepository.deleteGroup(id: id);
    result.fold((l) => emit(DeleteGroupError()), (r) {
      emit(DeleteGroupSuccess(groupId: id));
    });
  }
}
