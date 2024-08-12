import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/video%20shorts%20screen/data/models/shorts_list.dart';
import 'package:genix/features/video%20shorts%20screen/data/repos/shorts_repository.dart';

part 'get_posted_shorts_state.dart';

class GetPostedShortsCubit extends Cubit<GetPostedShortsState> {
  GetPostedShortsCubit() : super(GetPostedShortsInitial());
  final ShortsRepository getPostedShortsRepo = ShortsRepository();

  Future<void> getPostedShorts({required int uid}) async {
    emit(GetPostedShortsLoading());
    // result
    final result = await getPostedShortsRepo.getPostedShorts(uid: uid);
    result.fold(
        // error state
        (l) => emit(GetPostedShortsError()),
        //success state
        (r) {
      final shorts = ShortsList.fromJson(r as Map<String, dynamic>);
      emit(GetPostedShortsSuccess(shorts: shorts));
    });
  }
}
