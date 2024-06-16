import 'package:bloc/bloc.dart';
import 'package:genix/features/users/data/models/user_model.dart';
import 'package:genix/features/users/data/repos/user_repository.dart';
import 'package:meta/meta.dart';

part 'block_user_state.dart';

class BlockUserCubit extends Cubit<BlockUserState> {
  BlockUserCubit() : super(BlockUserInitial());
  final UserRepository getBlockedUsersRepo = UserRepository();
  Future postBlockedUser({required UserModel data, required String uid}) async {
    // loading state
    emit(BlockUserLoading());
    // result
    final result =
        await getBlockedUsersRepo.postRestrictUserRepo(data.toJson(), uid: uid);
    result.fold(
        // error state
        (l) => emit(BlockUserError()),
        // success state
        (r) {
      final blockedUser = UserModel.fromJson(data.toJson());
      emit(BlockUserSuccess(blockedUser: blockedUser));
    });
  }
}
