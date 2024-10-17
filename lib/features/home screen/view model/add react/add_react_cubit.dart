import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/summary.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'add_react_state.dart';

class AddReactCubit extends Cubit<AddReactState> {
  AddReactCubit() : super(AddReactInitial());
  final PostsRepository addReactionsRepo = PostsRepository();

  Future<void> addReactions(
      {required String reactionType, required int postId}) async {
    emit(AddReactLoading());

    final Map<String, dynamic> data = {'type': reactionType};

    final result = await addReactionsRepo.addReact(data: data, postId: postId);
    result.fold(
      (failure) => emit(AddReactError()),
      (success) => emit(AddReactSuccess(reactionType: reactionType)),
    );
  }
}
