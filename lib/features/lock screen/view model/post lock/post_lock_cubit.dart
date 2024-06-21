import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/lock%20screen/data/repos/lock_repository.dart';

part 'post_lock_state.dart';

class PostLockCubit extends Cubit<PostLockState> {
  PostLockCubit() : super(PostLockInitial());
  final LockRepository postLockRepo = LockRepository();
  Future<void> postLock() async {
    emit(PostLockLoading());
    final result = await postLockRepo.postLockAccount();
    result.fold(
        (l) => emit(PostLockError()), (r) => emit(PostLockSuccess(data: r)));
  }
}
