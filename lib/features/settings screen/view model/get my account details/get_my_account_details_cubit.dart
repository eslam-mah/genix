import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/settings%20screen/data/models/settings_list.dart';
import 'package:genix/features/settings%20screen/data/models/settings_model.dart';
import 'package:genix/features/settings%20screen/data/repos/setting_repository.dart';

part 'get_my_account_details_state.dart';

class GetMyAccountDetailsCubit extends Cubit<GetMyAccountDetailsState> {
  GetMyAccountDetailsCubit() : super(GetMyAccountDetailsInitial());
  final SettingRepository getMyAccountRepo = SettingRepository();
  Future<void> getMyAccountDetails() async {
    emit(GetMyAccountDetailsLoading());
    final result = await getMyAccountRepo.getMyAccountDetails();
    result.fold((l) => emit(GetMyAccountDetailsError()), (r) {
      final account = SettingsModel.fromJson(r as Map<String, dynamic>);
      emit(GetMyAccountDetailsSuccess(account: account));
    });
  }
}
