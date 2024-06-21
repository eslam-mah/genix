import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/profile%20screen/data/models/profile_model.dart';
import 'package:genix/features/profile%20screen/data/repos/profile_repository.dart';

part 'is_close_friend_state.dart';

class IsCloseFriendCubit extends Cubit<IsCloseFriendState> {
  IsCloseFriendCubit() : super(IsCloseFriendInitial());
  final ProfileRepository isCloseFriendRepo = ProfileRepository();
  Future<void> isCloseFriend(
      {required ProfileModel uid,
      required ProfileModel data,
      required ProfileModel isClose}) async {
    emit(IsCloseFriendLoading());
    final result = await isCloseFriendRepo.isCloseFriend(
        data: data.toJson(),
        uid: uid.user.id,
        isClose: isClose.followingCollection.first.isClose);
    result.fold((l) => emit(IsCloseFriendError()), (r) {
      final profile = ProfileModel.fromJson(data.toJson());
      emit(IsCloseFriendSuccess(profile: profile));
    });
  }
}
