import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/splash%20screen/data/models/validation_model.dart';
import 'package:genix/features/splash%20screen/data/repos/first_load_repository.dart';
import 'package:genix/core/services/http_reponse_status.dart';
import 'package:meta/meta.dart';

part 'first_load_state.dart';

class FirstLoadCubit extends Cubit<FirstLoadState> {
  FirstLoadCubit() : super(FirstLoadInitial());
  FirstLoadRepository firstLoadRepository = FirstLoadRepository();

  Future<void> firstLoad() async {
    emit(FirstLoadLoading());

    // Make the request to fetch first load data
    final result = await firstLoadRepository.getFirstLoad();

    // Handle the result from the repository
    result.fold(
      // Error state handling with the HttpResponseStatus enum
      (failure) {
        print("FirstLoadError: ${failure.message}");
        emit(FirstLoadError(
            message: failure.message, status: failure.responseStatus));
      },
      // Success state handling
      (data) {
        print("FirstLoadSuccess: $data");
        final firstLoad =
            ValidationModel.fromJson(data as Map<String, dynamic>);
        emit(FirstLoadSuccess(
            firstLoad: firstLoad, status: HttpResponseStatus.success));
      },
    );
  }
}
