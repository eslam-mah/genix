import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/video%20shorts%20screen/data/models/shorts_model.dart';
import 'package:genix/features/video%20shorts%20screen/data/repos/shorts_repository.dart';

part 'add_short_state.dart';

class AddShortCubit extends Cubit<AddShortState> {
  AddShortCubit() : super(AddShortInitial());
  final ShortsRepository addShortRepo = ShortsRepository();
  Future addShort({required File data, required String name}) async {
    // loading state
    emit(AddShortLoading());
    // result
    final result = await addShortRepo.addShort(short: data, name: name);
    result.fold(
        // error state
        (l) => emit(AddShortError()),
        // success state
        (r) {
      emit(AddShortSuccess(short: r["data"]["collection"]["id"]));
    });
  }
}
