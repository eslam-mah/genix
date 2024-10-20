import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/video%20shorts%20screen/data/models/shorts_list.dart';
import 'package:genix/features/video%20shorts%20screen/data/repos/shorts_repository.dart';

part 'get_shorts_state.dart';

class GetShortsCubit extends Cubit<GetShortsState> {
  GetShortsCubit() : super(GetShortsInitial());
  final ShortsRepository getShortsRepo = ShortsRepository();

  Future<void> getShorts() async {
    emit(GetShortsLoading());
    // result
    final result = await getShortsRepo.getShorts();
    result.fold(
        // error state
        (l) => emit(GetShortsError()),
        //success state
        (r) {
      final shorts = ShortsList.fromJson(r as Map<String, dynamic>);
      emit(GetShortsSuccess(shorts: shorts));
    });
  }
}
