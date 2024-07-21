import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/post_form.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/data.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'add_poll_post_state.dart';

class AddPollPostCubit extends Cubit<AddPollPostState> {
  AddPollPostCubit() : super(AddPollPostInitial());
  final PostsRepository addPollPostRepo = PostsRepository();
  Future<void> addPollPost(
      {required PostForm data,
      required Data postId,
      required int option}) async {
    emit(AddPollPostLoading());
    final result = await addPollPostRepo.addPollPost(
        data: data.toJson(),
        postId: postId.collection!.first.id,
        option: option);
    result.fold((l) => emit(AddPollPostError()), (r) {
      final post = PostForm.fromJson(data.toJson());
      emit(AddPollPostSuccess(post: post));
    });
  }
}
