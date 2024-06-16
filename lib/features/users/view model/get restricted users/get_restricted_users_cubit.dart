import 'package:bloc/bloc.dart';
import 'package:genix/features/users/data/models/users_list.dart';
import 'package:genix/features/users/data/repos/user_repository.dart';
import 'package:meta/meta.dart';

part 'get_restricted_users_state.dart';

class GetRestrictedUsersCubit extends Cubit<GetRestrictedUsersState> {
  GetRestrictedUsersCubit() : super(GetRestrictedUsersInitial());
  final UserRepository getRestrictedUsersRepo = UserRepository();

  Future<void> getRestrictedUsers({required String uid}) async {
    emit(GetRestrictedUsersLoading());
    // result
    final result =
        await getRestrictedUsersRepo.getRestrictedUsersRepo(uid: uid);
    result.fold(
        // error state
        (l) => emit(GetRestrictedUsersError()),
        //success state
        (r) {
      final users = UserList.fromJson(r as Map<String, dynamic>);
      emit(GetRestrictedUsersSuccess(users: users));
    });
  }
}
