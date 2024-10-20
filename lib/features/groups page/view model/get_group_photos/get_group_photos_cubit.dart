import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/groups%20page/data/models/group_profile_model/group_profile_model.dart';
import 'package:genix/features/groups%20page/data/repos/groups_repository.dart';

part 'get_group_photos_state.dart';

class GetGroupPhotosCubit extends Cubit<GetGroupPhotosState> {
  GetGroupPhotosCubit() : super(GetGroupPhotosInitial());
  final GroupsRepository groupsRepository = GroupsRepository();
  Future<void> getGroupPhotos({required int id}) async {
    emit(GetGroupPhotosLoading());
    final result = await groupsRepository.getGroupPhotos(id: id);
    result.fold(
      (l) => emit(GetGroupPhotosError()),
      (r) {
        final group = GroupProfileModel.fromJson(r as Map<String, dynamic>);
        emit(GetGroupPhotosSuccess(group: group));
      },
    );
  }
}
