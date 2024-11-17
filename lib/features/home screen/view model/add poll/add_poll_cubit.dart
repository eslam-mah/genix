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
  Future<void> addPollPost({required int postId, required int option}) async {
    emit(AddPollLoading());
    final result =
        await addPollPostRepo.addPollPost(option: option, postId: postId);
    result.fold((l) => emit(AddPollError()), (r) {
      emit(AddPollSuccess(post: 'Poll added successfully'));
    });
  }
}
