import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/video%20shorts%20screen/data/models/shorts_list.dart';
import 'package:genix/features/video%20shorts%20screen/data/repos/shorts_repository.dart';

part 'get_saved_shorts_state.dart';

class GetSavedShortsCubit extends Cubit<GetSavedShortsState> {
  GetSavedShortsCubit() : super(GetSavedShortsInitial());
  final ShortsRepository getSavedShortsRepo = ShortsRepository();

  Future<void> getSavedShorts({required int uid}) async {
    emit(GetSavedShortsLoading());
    // result
    final result = await getSavedShortsRepo.getSavedShorts(uid: uid);
    result.fold(
        // error state
        (l) => emit(GetSavedShortsError()),
        //success state
        (r) {
      final shorts = ShortsList.fromJson(r as Map<String, dynamic>);
      emit(GetSavedShortsSuccess(shorts: shorts));
    });
  }
}
