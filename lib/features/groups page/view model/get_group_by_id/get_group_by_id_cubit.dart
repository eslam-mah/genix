import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/groups%20page/data/models/group_profile_model/group_profile_model.dart';
import 'package:genix/features/groups%20page/data/repos/groups_repository.dart';

part 'get_group_by_id_state.dart';

class GetGroupByIdCubit extends Cubit<GetGroupByIdState> {
  GetGroupByIdCubit() : super(GetGroupByIdInitial());
  final GroupsRepository groupsRepository = GroupsRepository();
  Future<void> getGroupById({required int id}) async {
    emit(GetGroupByIdLoading());
    final result = await groupsRepository.getGroupById(id: id);
    result.fold(
      (l) => emit(GetGroupByIdError()),
      (r) {
        final group = GroupProfileModel.fromJson(r as Map<String, dynamic>);
        emit(GetGroupByIdSuccess(group: group));
      },
    );
  }
}
