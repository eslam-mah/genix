import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/pages%20screen/data/repos/pages_repository.dart';

part 'delete_page_member_post_state.dart';

class DeletePageMemberPostCubit extends Cubit<DeletePageMemberPostState> {
  DeletePageMemberPostCubit() : super(DeletePageMemberPostInitial());
  final PagesRepository pagesRepository = PagesRepository();
  Future<void> deletePageMemberPost({required int id}) async {
    emit(DeletePageMemberPostLoading());
    final result = await pagesRepository.deletePageMemberPost(id: id);
    result.fold((l) => emit(DeletePageMemberPostError()), (r) {
      emit(DeletePageMemberPostSuccess(id: id));
    });
  }
}
