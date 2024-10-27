import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/pages%20screen/data/models/pages_list.dart';
import 'package:genix/features/pages%20screen/data/repos/pages_repository.dart';

part 'get_all_pages_state.dart';

class GetAllPagesCubit extends Cubit<GetAllPagesState> {
  GetAllPagesCubit() : super(GetAllPagesInitial());
  final PagesRepository pagesRepository = PagesRepository();
  Future<void> getAllPages({required int page}) async {
    emit(GetAllPagesLoading());
    final result = await pagesRepository.getPagesList(page: page);
    result.fold(
      (l) => emit(GetAllPagesError()),
      (r) {
        final pages = PagesList.fromJson(r as Map<String, dynamic>);
        emit(GetAllPagesSuccess(pages: pages));
      },
    );
  }
}
