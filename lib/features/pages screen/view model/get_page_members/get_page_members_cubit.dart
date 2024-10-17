import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/pages%20screen/data/models/group_profile_model/page_profile_model.dart';
import 'package:genix/features/pages%20screen/data/repos/pages_repository.dart';

part 'get_page_members_state.dart';

class GetPageMembersCubit extends Cubit<GetPageMembersState> {
  GetPageMembersCubit() : super(GetPageMembersInitial());
  final PagesRepository pagesRepository = PagesRepository();
  Future<void> getPageMembers({required int id}) async {
    emit(GetPageMembersLoading());
    final result = await pagesRepository.getPageMembers(id: id);
    result.fold(
      (l) => emit(GetPageMembersError()),
      (r) {
        final page = PageProfileModel.fromJson(r as Map<String, dynamic>);
        emit(GetPageMembersSuccess(page: page));
      },
    );
  }
}
