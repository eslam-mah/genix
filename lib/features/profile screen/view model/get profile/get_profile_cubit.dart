import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/profile%20screen/data/models/profile_list.dart';
import 'package:genix/features/profile%20screen/data/models/profile_model.dart';
import 'package:genix/features/profile%20screen/data/repos/profile_repository.dart';

part 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  GetProfileCubit() : super(GetProfileInitial());
  final ProfileRepository getProfileRepo = ProfileRepository();
  Future<void> getProfile({required ProfileModel profileName}) async {
    emit(GetProfileLoading());
    final result = await getProfileRepo.getProfileData(
        profileName: profileName.user.showname);
    result.fold((l) => emit(GetProfileError()), (r) {
      final profiles = ProfileList.fromJson(r as Map<String, dynamic>);
      emit(GetProfileSuccess(profiles: profiles));
    });
  }
}
