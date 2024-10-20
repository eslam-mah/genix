import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/profile%20screen/data/repos/profile_repository.dart';

part 'remove_friend_state.dart';

class RemoveFriendCubit extends Cubit<RemoveFriendState> {
  RemoveFriendCubit() : super(RemoveFriendInitial());
  final ProfileRepository removeFriendRepo = ProfileRepository();
  Future<void> removeFriend({required int uid}) async {
    emit(RemoveFriendLoading());
    final result = await removeFriendRepo.removeFriend(uid: uid);
    result.fold((l) {
      emit(RemoveFriendError());
      print('Error occurred while removing friend: ${l.message}');
      print('errorrrrrrrrrrrrr');
    }, (r) {
      emit(RemoveFriendSuccess(uid: uid));
      print('successsss');
    });
  }
}
