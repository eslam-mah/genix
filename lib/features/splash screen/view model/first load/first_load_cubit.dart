import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/splash%20screen/data/models/validation_model.dart';
import 'package:genix/features/splash%20screen/data/repos/first_load_repository.dart';
import 'package:meta/meta.dart';

part 'first_load_state.dart';

class FirstLoadCubit extends Cubit<FirstLoadState> {
  FirstLoadCubit() : super(FirstLoadInitial());
  final FirstLoadRepository getFirstLoad = FirstLoadRepository();

  Future<void> firstLoad() async {
    emit(FirstLoadLoading());
    // result
    final result = await getFirstLoad.getFirstLoad();
    result.fold(
        // error state
        (l) {
      print("FirstLoadError: ${l.message}"); // Debugging line
      emit(FirstLoadError());
    },
        // success state
        (r) {
      print("FirstLoadSuccess: $r"); // Debugging line
      final firstLoad = ValidationModel.fromJson(r as Map<String, dynamic>);
      emit(FirstLoadSuccess(firstLoad: firstLoad));
    });
  }
}
