import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/profile%20screen/data/profile_model/profile_model.dart';
import 'package:genix/features/profile%20screen/data/repos/profile_repository.dart';

part 'get_profile_state.dart';

class GetProfileCubit extends Cubit<GetProfileState> {
  GetProfileCubit() : super(GetProfileInitial());
  final ProfileRepository getProfileRepo = ProfileRepository();
  Future<void> getProfile({required String profileName}) async {
    emit(GetProfileLoading());
    final result =
        await getProfileRepo.getProfileData(profileName: profileName);
    result.fold((l) => emit(GetProfileError()), (r) {
      final profiles = ProfileModel.fromJson(r as Map<String, dynamic>);
      emit(GetProfileSuccess(profiles: profiles));
    });
  }
}
