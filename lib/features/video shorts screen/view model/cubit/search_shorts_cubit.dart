import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/video%20shorts%20screen/data/models/shorts_model.dart';
import 'package:genix/features/video%20shorts%20screen/data/repos/shorts_repository.dart';

part 'search_shorts_state.dart';

class SearchShortsCubit extends Cubit<SearchShortsState> {
  SearchShortsCubit() : super(SearchShortsInitial());
  final ShortsRepository searchShortRepo = ShortsRepository();
  Future searchShort() async {
    // loading state
    emit(SearchShortsLoading());
    // result
    final result = await searchShortRepo.searchShorts();
    result.fold(
        // error state
        (l) => emit(SearchShortsError()),
        // success state
        (r) {
      final short = ShortsModel.fromJson(r as Map<String, dynamic>);

      emit(SearchShortsSuccess(short: short));
    });
  }
}
