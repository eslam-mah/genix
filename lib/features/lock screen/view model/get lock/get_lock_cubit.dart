import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/lock%20screen/data/model/lock_model.dart';
import 'package:genix/features/lock%20screen/data/repos/lock_repository.dart';

part 'get_lock_state.dart';

class GetLockCubit extends Cubit<GetLockState> {
  GetLockCubit() : super(GetLockInitial());
  final LockRepository getLockRepo = LockRepository();
  Future<void> getLock() async {
    emit(GetLockLoading());
    final result = await getLockRepo.getLockAccount();
    result.fold((l) => emit(GetLockError()), (r) {
      final lock = LockModel.fromJson(r as Map<String, dynamic>);
      emit(GetLockSuccess(data: lock));
    });
  }
}
