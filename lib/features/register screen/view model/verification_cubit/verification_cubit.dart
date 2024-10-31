import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/register%20screen/data/repo/register_repository.dart';

part 'verification_state.dart';

class VerificationCubit extends Cubit<VerificationState> {
  VerificationCubit() : super(VerificationInitial());
  final RegisterRepository registerRepository = RegisterRepository();
  Future<void> verifyEmail() async {
    emit(VerificationLoading());

    final result = await registerRepository.verifyEmail();
    result.fold(
      (failure) => emit(VerificationError()),
      (response) => emit(const VerificationSuccess(
          message: 'Verification Link Sent, please check your email')),
    );
  }
}
