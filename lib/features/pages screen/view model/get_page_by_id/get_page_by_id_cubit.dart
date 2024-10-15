import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/pages%20screen/data/models/group_profile_model/page_profile_model.dart';
import 'package:genix/features/pages%20screen/data/repos/pages_repository.dart';

part 'get_page_by_id_state.dart';

class GetPageByIdCubit extends Cubit<GetPageByIdState> {
  GetPageByIdCubit() : super(GetPageByIdInitial());
  final PagesRepository pagesRepository = PagesRepository();
  Future<void> getPageById({required int id}) async {
    emit(GetPageByIdLoading());
    final result = await pagesRepository.getPageById(id: id);
    result.fold(
      (l) => emit(GetPageByIdError()),
      (r) {
        final page = PageProfileModel.fromJson(r as Map<String, dynamic>);
        emit(GetPageByIdSuccess(page: page));
      },
    );
  }
}
