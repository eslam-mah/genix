import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/settings%20screen/data/repos/setting_repository.dart';

part 'delete_my_account_state.dart';

class DeleteMyAccountCubit extends Cubit<DeleteMyAccountState> {
  DeleteMyAccountCubit() : super(DeleteMyAccountInitial());
  final SettingRepository deleteAccountRepo = SettingRepository();
  Future<void> deleteAccount(String id) async {
    emit(DeleteMyAccountLoading());
    final result = await deleteAccountRepo.deleteMyAccount();
    result.fold((l) => emit(DeleteMyAccountError()),
        (r) => emit(DeleteMyAccountSuccess(account: id)));
  }
}
