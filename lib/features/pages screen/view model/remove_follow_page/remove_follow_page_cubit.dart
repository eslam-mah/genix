import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/pages%20screen/data/repos/pages_repository.dart';

part 'remove_follow_page_state.dart';

class RemoveFollowPageCubit extends Cubit<RemoveFollowPageState> {
  RemoveFollowPageCubit() : super(RemoveFollowPageInitial());
  final PagesRepository pagesRepository = PagesRepository();
  Future<void> removeFollowPage({required int id}) async {
    emit(RemoveFollowPageLoading());
    final result = await pagesRepository.removeFollowPage(id: id);
    result.fold((l) => emit(RemoveFollowPageError()), (r) {
      emit(RemoveFollowPageSuccess(id: id));
    });
  }
}
