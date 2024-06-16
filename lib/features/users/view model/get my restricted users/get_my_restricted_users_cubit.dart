import 'package:bloc/bloc.dart';
import 'package:genix/features/users/data/models/users_list.dart';
import 'package:genix/features/users/data/repos/user_repository.dart';
import 'package:meta/meta.dart';

part 'get_my_restricted_users_state.dart';

class GetMyRestrictedUsersCubit extends Cubit<GetMyRestrictedUsersState> {
  GetMyRestrictedUsersCubit() : super(GetMyRestrictedUsersInitial());
  final UserRepository getMyRestrictedUsersRepo = UserRepository();

  Future<void> getMyRestrictedUsers({required String uid}) async {
    emit(GetMyRestrictedUsersLoading());
    // result
    final result =
        await getMyRestrictedUsersRepo.getRestrictedUsersRepo(uid: uid);
    result.fold(
        // error state
        (l) => emit(GetMyRestrictedUsersError()),
        //success state
        (r) {
      final users = UserList.fromJson(r as Map<String, dynamic>);
      emit(GetMyRestrictedUsersSuccess(users: users));
    });
  }
}
