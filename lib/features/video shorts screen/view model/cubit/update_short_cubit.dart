import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/video%20shorts%20screen/data/models/shorts_model.dart';
import 'package:genix/features/video%20shorts%20screen/data/repos/shorts_repository.dart';

part 'update_short_state.dart';

class UpdateShortCubit extends Cubit<UpdateShortState> {
  UpdateShortCubit() : super(UpdateShortInitial());
  final ShortsRepository updateShortRepo = ShortsRepository();
  Future updateShort(
      {required File data, required String name, required String id}) async {
    // loading state
    emit(UpdateShortLoading());
    // result
    final result =
        await updateShortRepo.updateShort(id: id, short: data, name: name);
    result.fold(
        // error state
        (l) => emit(UpdateShortError()),
        // success state
        (r) {
      emit(UpdateShortSuccess(short: r["data"]["collection"]["id"]));
    });
  }
}
