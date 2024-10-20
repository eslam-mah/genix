import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/pages%20screen/data/models/update_page_memeber_form.dart';
import 'package:genix/features/pages%20screen/data/repos/pages_repository.dart';

part 'update_page_member_state.dart';

class UpdatePageMemberCubit extends Cubit<UpdatePageMemberState> {
  UpdatePageMemberCubit() : super(UpdatePageMemberInitial());
  final PagesRepository pagesRepository = PagesRepository();
  Future<void> updatePageMember(
      {required Map<String, dynamic> data, required int id}) async {
    emit(UpdatePageMemberLoading());
    final result = await pagesRepository.updatePageMember(data: data, id: id);
    result.fold(
      (l) => emit(UpdatePageMemberError()),
      (r) {
        final updatePageMember = UpdatePageFollowerForm.fromJson(data);
        emit(UpdatePageMemberSuccess(follower: updatePageMember));
      },
    );
  }
}
