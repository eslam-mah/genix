import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/pages%20screen/data/repos/pages_repository.dart';

part 'update_page_invitation_state.dart';

class UpdatePageInvitationCubit extends Cubit<UpdatePageInvitationState> {
  UpdatePageInvitationCubit() : super(UpdatePageInvitationInitial());
  final PagesRepository pagesRepository = PagesRepository();
  Future<void> updatePageInvitation(
      {required Map<String, dynamic> data, required int id}) async {
    emit(UpdatePageInvitationLoading());
    final result = await pagesRepository.followPage(data: data, id: id);
    result.fold(
      (l) => emit(UpdatePageInvitationError()),
      (r) {
        emit(const UpdatePageInvitationSuccess(
            message: 'Group Invitation Updated'));
      },
    );
  }
}
