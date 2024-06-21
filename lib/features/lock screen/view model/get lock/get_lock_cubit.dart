import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/lock%20screen/data/repos/lock_repository.dart';

part 'get_lock_state.dart';

class GetLockCubit extends Cubit<GetLockState> {
  GetLockCubit() : super(GetLockInitial());
  final LockRepository getLockRepo = LockRepository();
  Future<void> getLock() async {
    emit(GetLockLoading());
    final result = await getLockRepo.getLockAccount();
    result.fold(
        (l) => emit(GetLockError()), (r) => emit(GetLockSuccess(data: r)));
  }
}
