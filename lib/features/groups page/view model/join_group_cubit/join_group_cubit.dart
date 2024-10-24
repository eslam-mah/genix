import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/groups%20page/data/repos/groups_repository.dart';

part 'join_group_state.dart';

class JoinGroupCubit extends Cubit<JoinGroupState> {
  JoinGroupCubit() : super(JoinGroupInitial());
  final GroupsRepository groupsRepository = GroupsRepository();
  Future<void> joinGroup({Map<String, dynamic>? data, required int id}) async {
    emit(JoinGroupLoading());
    final result = await groupsRepository.joinGroup(data: data ?? {}, id: id);
    result.fold(
      (l) => emit(JoinGroupError()),
      (r) {
        emit(const JoinGroupSuccess('Group joined successfully'));
      },
    );
  }
}
