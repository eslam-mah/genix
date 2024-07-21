import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_list.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/data.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'get_photo_posts_state.dart';

class GetPhotoPostsCubit extends Cubit<GetPhotoPostsState> {
  GetPhotoPostsCubit() : super(GetPhotoPostsInitial());
  final PostsRepository getPhotoPostsRepo = PostsRepository();
  Future<void> getPhotoPosts({required PostsModel uid}) async {
    emit(GetPhotoPostsLoading());
    final result = await getPhotoPostsRepo.getPhotoPosts(uid: uid.user!.id);
    result.fold((l) => emit(GetPhotoPostsError()), (r) {
      final photoPosts = PostsList.fromJson(r as Map<String, dynamic>);
      emit(GetPhotoPostsSuccess(photoPosts: photoPosts));
    });
  }
}
