import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/pages%20screen/data/models/group_profile_model/page_profile_model.dart';
import 'package:genix/features/pages%20screen/data/repos/pages_repository.dart';

part 'get_page_photos_state.dart';

class GetPagePhotosCubit extends Cubit<GetPagePhotosState> {
  GetPagePhotosCubit() : super(GetPagePhotosInitial());
  final PagesRepository pagesRepository = PagesRepository();
  Future<void> getPagePhotos({required int id}) async {
    emit(GetPagePhotosLoading());
    final result = await pagesRepository.getPagePhotos(id: id);
    result.fold(
      (l) => emit(GetPagePhotosError()),
      (r) {
        final page = PageProfileModel.fromJson(r as Map<String, dynamic>);
        emit(GetPagePhotosSuccess(page: page));
      },
    );
  }
}
