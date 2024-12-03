import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:genix/features/login%20screen/data/models/response_model.dart';
import 'package:genix/features/login%20screen/data/repos/log_in_repository.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitial());
  final LogInRepository logInRepository = LogInRepository();

  LoginResponse? _loginResponse;

  Future<void> logIn({
    required String email,
    required String password,
    String? code, // For 2FA or recovery code
  }) async {
    emit(LogInLoading());

    final result = await logInRepository.logIn(
      email: email,
      password: password,
      code: code,
    );

    result.fold(
          (failure) => emit(LogInError(message: failure.message ?? '')),
          (response) {
        final loginResponse = LoginResponse.fromJson(response);

        if (loginResponse.token != null) {
          emit(LogInSuccess(data: response));
        } else {
          emit(const LogInTwoFactorRequired());
        }
      },
    );

  }

  String? get token => _loginResponse?.token;
}
