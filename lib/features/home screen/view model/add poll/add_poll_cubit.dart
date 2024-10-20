import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/post_form.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/data.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'add_poll_state.dart';

class AddPollCubit extends Cubit<AddPollState> {
  AddPollCubit() : super(AddPollInitial());
  final PostsRepository addPollPostRepo = PostsRepository();
  Future<void> addPollPost(
      {required PostsModel data,
      required int postId,
      required int option}) async {
    emit(AddPollLoading());
    final result = await addPollPostRepo.addPollPost(
        data: data.toJson(), postId: postId, option: option);
    result.fold((l) => emit(AddPollError()), (r) {
      final post = PostsModel.fromJson(data.toJson());
      emit(AddPollSuccess(post: post));
    });
  }
}
