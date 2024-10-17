import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/pages%20screen/data/repos/pages_repository.dart';

part 'delete_page_member_state.dart';

class DeletePageMemberCubit extends Cubit<DeletePageMemberState> {
  DeletePageMemberCubit() : super(DeletePageMemberInitial());
  final PagesRepository pagesRepository = PagesRepository();
  Future<void> deletePageMember({required int id}) async {
    emit(DeletePageMemberLoading());
    final result = await pagesRepository.deletePageMember(id: id);
    result.fold((l) => emit(DeletePageMemberError()), (r) {
      emit(DeletePageMemberSuccess(id: id));
    });
  }
}
