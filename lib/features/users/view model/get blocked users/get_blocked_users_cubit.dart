import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/users/data/models/users_list.dart';
import 'package:genix/features/users/data/repos/user_repository.dart';
import 'package:meta/meta.dart';

part 'get_blocked_users_state.dart';

class GetBlockedUsersCubit extends Cubit<GetBlockedUsersState> {
  GetBlockedUsersCubit() : super(GetBlockedUsersInitial());
  final UserRepository getBlockedUsersRepo = UserRepository();

  Future<void> getBlockedUsers({required String uid}) async {
    emit(GetBlockedUsersLoading());
    // result
    final result = await getBlockedUsersRepo.getBlockedUsersRepo(uid: uid);
    result.fold(
        // error state
        (l) => emit(GetBlockedUsersError()),
        //success state
        (r) {
      final users = UserList.fromJson(r as Map<String, dynamic>);
      emit(GetBlockedUsersSuccess(users: users));
    });
  }
}
