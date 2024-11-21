import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/lock%20screen/data/repos/lock_repository.dart';

part 'remove_lock_state.dart';

class RemoveLockCubit extends Cubit<RemoveLockState> {
  RemoveLockCubit() : super(RemoveLockInitial());
  final LockRepository removeLockRepo = LockRepository();
  Future<void> removeLock({required String password}) async {
    emit(RemoveLockLoading());
    final result = await removeLockRepo.removeLockAccount(password: password);
    result.fold((l) => emit(RemoveLockError(error: l.message ?? '')), (r) {
      emit(const RemoveLockSuccess(lock: 'lock removed successfully'));
    });
  }
}
