import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/users/data/repos/user_repository.dart';
import 'package:meta/meta.dart';

part 'delete_user_state.dart';

class DeleteUserCubit extends Cubit<DeleteUserState> {
  DeleteUserCubit() : super(DeleteUserInitial());
  final UserRepository deleteUserRepo = UserRepository();
// make request
  Future deleteUser({
    required String id,
  }) async {
    // loading state
    emit(DeleteUserLoading());
    // result
    final result = await deleteUserRepo.deleteBlockUserRepo(id: id);
    result.fold(
        // error state
        (l) => emit(DeleteUserError()),
        // success state
        (r) {
      emit(DeleteUserSuccess(user: id));
    });
  }
}
