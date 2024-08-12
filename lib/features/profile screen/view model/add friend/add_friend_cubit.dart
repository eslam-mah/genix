import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/profile%20screen/data/profile_model/profile_model.dart';
import 'package:genix/features/profile%20screen/data/repos/profile_repository.dart';

part 'add_friend_state.dart';

class AddFriendCubit extends Cubit<AddFriendState> {
  AddFriendCubit() : super(AddFriendInitial());
  final ProfileRepository addFriendRepo = ProfileRepository();
  Future<void> addFriend({required ProfileModel data, required int uid}) async {
    emit(AddFriendLoading());
    final result = await addFriendRepo.addFriend(data: data.toJson(), uid: uid);
    result.fold((l) => emit(AddFriendError()), (r) {
      final profile = ProfileModel.fromJson(data.toJson());
      emit(AddFriendSuccess(profile: profile));
    });
  }
}
