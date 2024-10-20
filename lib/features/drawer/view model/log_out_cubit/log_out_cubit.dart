import 'package:equatable/equatable.dart';
import 'package:genix/core/services/shared_preferences.dart';
import 'package:genix/features/logout/data/repos/log_out_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/pref_keys.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit() : super(LogOutInitial());

  final LogOutRepository logOutRepo = LogOutRepository();

  Future<void> logOut() async {
    emit(LogOutLoading());

    final result = await logOutRepo.logOut();

    result.fold(
      (l) => emit(LogOutError()),
      (r) {
        emit(const LogOutSuccess(message: 'Logged out successfully'));
        CacheData.deleteData(key: PrefKeys.kToken);
      },
    );
  }
}
