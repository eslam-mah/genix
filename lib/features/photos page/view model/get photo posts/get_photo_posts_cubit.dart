import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/photos%20page/data/models/photos_list.dart';
import 'package:genix/features/photos%20page/data/repos/photos_repository.dart';
import 'package:genix/features/photos%20page/view%20model/get%20photo%20posts/get_photo_posts_cubit.dart';
import 'package:genix/features/photos%20page/view%20model/get%20photo%20posts/get_photo_posts_state.dart';

class GetPhotoPostsCubit extends Cubit<GetPhotoPostsState> {
  GetPhotoPostsCubit() : super(GetPhotoPostsInitial());
  final PhotosRepository getPhotoPostsRepo = PhotosRepository();
  Future<void> getPhotoPosts({required int uid}) async {
    emit(GetPhotoPostsLoading());
    final result = await getPhotoPostsRepo.getPhotoPosts(uid: uid);
    result.fold((l) => emit(GetPhotoPostsError()), (r) {
      final photoPosts = PhotosList.fromJson(r as Map<String, dynamic>);
      emit(GetPhotoPostsSuccess(photoPosts: photoPosts));
    });
  }
}
