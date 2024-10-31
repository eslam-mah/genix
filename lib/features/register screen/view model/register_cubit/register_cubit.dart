import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/register%20screen/data/repo/register_repository.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  final RegisterRepository registerRepository = RegisterRepository();

  Future<void> register({
    required String email,
    required String password,
    required String showName,
    required String userName,
    required String passwordConfirmation,
    required String country,
    required String locale,
    required String dateOfBirth,
  }) async {
    emit(RegisterLoading());

    final result = await registerRepository.register(
        email: email,
        password: password,
        showName: showName,
        userName: userName,
        passwordConfirmation: passwordConfirmation,
        country: country,
        locale: locale,
        dateOfBirth: dateOfBirth);

    result.fold(
      (failure) =>
          emit(RegisterError(message: failure.message ?? '')), // Error state
      (response) {
        emit(const RegisterSuccess(
            message: 'Register Success, now verify')); // Success state
      },
    );
  }
}
