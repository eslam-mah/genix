import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/logout/data/repos/log_out_repository.dart';

part 'log_out_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit() : super(LogOutInitial());
  final LogOutRepository logOutRepo = LogOutRepository();
  Future<void> logOut() async {
    emit(LogOutLoading());
    final result = await logOutRepo.logOut();
    result.fold((l) => emit(LogOutError()),
        (r) => emit(LogOutSuccess(message: 'Logged out successfully')));
  }
}
