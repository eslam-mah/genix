import 'package:bloc/bloc.dart';
import 'package:genix/features/users/data/repos/user_repository.dart';
import 'package:meta/meta.dart';

part 'delete_block_state.dart';

class DeleteBlockCubit extends Cubit<DeleteBlockState> {
  DeleteBlockCubit() : super(DeleteBlockInitial());
  final UserRepository deleteBlockRepo = UserRepository();
// make request
  Future deleteBlock({
    required String id,
  }) async {
    // loading state
    emit(DeleteBlockLoading());
    // result
    final result = await deleteBlockRepo.deleteBlockUserRepo(id: id);
    result.fold(
        // error state
        (l) => emit(DeleteBlockError()),
        // success state
        (r) {
      emit(DeleteBlockSuccess(block: id));
    });
  }
}
