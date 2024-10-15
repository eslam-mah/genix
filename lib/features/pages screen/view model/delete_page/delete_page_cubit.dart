import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/pages%20screen/data/repos/pages_repository.dart';

part 'delete_page_state.dart';

class DeletePageCubit extends Cubit<DeletePageState> {
  DeletePageCubit() : super(DeletePageInitial());
  final PagesRepository pagesRepository = PagesRepository();
  Future<void> deletePage({required int id}) async {
    emit(DeletePageLoading());
    final result = await pagesRepository.deletePage(id: id);
    result.fold((l) => emit(DeletePageError()), (r) {
      emit(DeletePageSuccess(id: id));
    });
  }
}
