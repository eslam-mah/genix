import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/login%20screen/data/models/response_model.dart';
import 'package:genix/features/login%20screen/data/repos/log_in_repository.dart';
import 'package:meta/meta.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitial());
  final LogInRepository logInRepository = LogInRepository();

  LoginResponse? _loginResponse;

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    emit(LogInLoading());

    final result =
        await logInRepository.logIn(email: email, password: password);

    result.fold(
      (failure) => emit(LogInError()), // Error state
      (response) {
        _loginResponse = LoginResponse.fromJson(response);

        emit(LogInSuccess(data: response)); // Success state
      },
    );
  }

  String? get token => _loginResponse?.token;
}
