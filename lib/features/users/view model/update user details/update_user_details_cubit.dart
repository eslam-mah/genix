import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/users/data/models/user_form.dart';
import 'package:genix/features/users/data/models/user_model.dart';
import 'package:genix/features/users/data/repos/user_repository.dart';
import 'package:meta/meta.dart';

part 'update_user_details_state.dart';

class UpdateUserDetailsCubit extends Cubit<UpdateUserDetailsState> {
  UpdateUserDetailsCubit() : super(UpdateUserDetailsInitial());
  final UserRepository updateUserDetailsRepo = UserRepository();
// make request
  Future updateUserDetails({
    required UserForm data,
    required UserModel uid,
  }) async {
    // loading state
    emit(UpdateUserDetailsLoading());
    // result
    final result = await updateUserDetailsRepo.updateUserDetails(data.toJson(),
        uid: uid.id);
    result.fold(
        // error state
        (l) => emit(UpdateUserDetailsError()),
        // success state
        (r) {
      final updateUser = UserForm.fromJson(data.toJson());
      emit(UpdateUserDetailsSuccess(updateUser: updateUser));
    });
  }
}
