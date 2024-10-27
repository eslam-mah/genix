import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/pages%20screen/data/models/page_profile_model/member_list.dart';
import 'package:genix/features/pages%20screen/data/repos/pages_repository.dart';

part 'get_page_members_state.dart';

class GetPageMembersCubit extends Cubit<GetPageMembersState> {
  GetPageMembersCubit() : super(GetPageMembersInitial());
  final PagesRepository pagesRepository = PagesRepository();
  Future<void> getPageMembers({required int id, required int page}) async {
    emit(GetPageMembersLoading());
    final result = await pagesRepository.getPageMembers(id: id, page: page);
    result.fold(
      (l) => emit(GetPageMembersError()),
      (r) {
        final member = MembersList.fromJson(r as Map<String, dynamic>);
        emit(GetPageMembersSuccess(member: member));
      },
    );
  }
}
