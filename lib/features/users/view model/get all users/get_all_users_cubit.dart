import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/users/data/models/users_list.dart';
import 'package:genix/features/users/data/repos/user_repository.dart';
import 'package:meta/meta.dart';

part 'get_all_users_state.dart';

class GetAllUsersCubit extends Cubit<GetAllUsersState> {
  GetAllUsersCubit() : super(GetAllUsersInitial());
  final UserRepository getAllUsersRepo = UserRepository();

  Future<void> getAllUsers() async {
    emit(GetAllUsersLoading());
    // result
    final result = await getAllUsersRepo.getAllUsersRepo();
    result.fold(
        // error state
        (l) => emit(GetAllUsersError()),
        //success state
        (r) {
      final users = UserList.fromJson(r as Map<String, dynamic>);
      emit(GetAllUsersSuccess(users: users));
    });
  }
}
