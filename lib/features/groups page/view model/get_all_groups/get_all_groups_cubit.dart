import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/groups%20page/data/models/groups_list.dart';
import 'package:genix/features/groups%20page/data/repos/groups_repository.dart';
import 'package:genix/features/pages%20screen/data/models/pages_list.dart';

part 'get_all_groups_state.dart';

class GetAllGroupsCubit extends Cubit<GetAllGroupsState> {
  GetAllGroupsCubit() : super(GetAllGroupsInitial());
  final GroupsRepository groupsRepository = GroupsRepository();
  Future<void> getAllGroups() async {
    emit(GetAllGroupsLoading());
    final result = await groupsRepository.getGroupsList();
    result.fold(
      (l) => emit(GetAllGroupsError()),
      (r) {
        final groups = GroupsList.fromJson(r as Map<String, dynamic>);
        emit(GetAllGroupsSuccess(groups: groups));
      },
    );
  }
}
