import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/data.dart';
import 'package:genix/features/home%20screen/data/models/share_form.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'share_post_state.dart';

class SharePostCubit extends Cubit<SharePostState> {
  SharePostCubit() : super(SharePostInitial());
  final PostsRepository sharePostRepo = PostsRepository();
  Future<void> sharePost({required ShareForm data, required int postId}) async {
    emit(SharePostLoading());
    final result =
        await sharePostRepo.sharePost(data: data.toJson(), postId: postId);
    result.fold((l) => emit(SharePostError()), (r) {
      final share = ShareForm.fromJson(data.toJson());
      SharePostSuccess(share: share);
    });
  }
}
