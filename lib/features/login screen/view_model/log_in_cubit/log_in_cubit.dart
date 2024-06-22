import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/login%20screen/data/repos/log_in_repository.dart';
import 'package:meta/meta.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitial());
  final LogInRepository logInRepository = LogInRepository();
// make request
  Future logIn({
    required String email,
    required String password,
  }) async {
    // loading state
    emit(LogInLoading());
    // result
    final result =
        await logInRepository.logIn(email: email, password: password);
    result.fold(
        // error state
        (l) => emit(LogInError()),
        // success state

        (r) {
      emit(LogInSuccess(
        data: r,
      ));
    });
  }
}
