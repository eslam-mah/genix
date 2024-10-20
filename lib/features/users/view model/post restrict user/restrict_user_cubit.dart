import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/users/data/models/user_model.dart';
import 'package:genix/features/users/data/repos/user_repository.dart';
import 'package:meta/meta.dart';

part 'restrict_user_state.dart';

class RestrictUserCubit extends Cubit<RestrictUserState> {
  RestrictUserCubit() : super(RestrictUserInitial());
  final UserRepository postRestrictRepo = UserRepository();
// make request
  Future postRestrictedUser(
      {required UserModel data, required String uid}) async {
    // loading state
    emit(RestrictUserLoading());
    // result
    final result =
        await postRestrictRepo.postRestrictUserRepo(data.toJson(), uid: uid);
    result.fold(
        // error state
        (l) => emit(RestrictUserError()),
        // success state
        (r) {
      final restrictedUser = UserModel.fromJson(data.toJson());
      emit(RestrictUserSuccess(restrictedUser: restrictedUser));
    });
  }
}
