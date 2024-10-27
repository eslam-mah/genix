import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/pages%20screen/data/repos/pages_repository.dart';

part 'follow_page_state.dart';

class FollowPageCubit extends Cubit<FollowPageState> {
  FollowPageCubit() : super(FollowPageInitial());
  final PagesRepository pagesRepository = PagesRepository();
  Future<void> followPage({required int id}) async {
    emit(FollowPageLoading());
    final result = await pagesRepository.followPage(data: {}, id: id);
    result.fold(
      (l) => emit(FollowPageError()),
      (r) {
        emit(const FollowPageSuccess(message: 'Group joined successfully'));
      },
    );
  }
}
