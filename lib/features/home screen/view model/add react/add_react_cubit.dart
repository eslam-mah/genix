import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/data.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/summary.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'add_react_state.dart';

class AddReactCubit extends Cubit<AddReactState> {
  AddReactCubit() : super(AddReactInitial());
  final PostsRepository addReactionsRepo = PostsRepository();

  Future<void> addReactions(
      {required Summary data, required Data postId}) async {
    emit(AddReactLoading());
    final result = await addReactionsRepo.addReact(
        data: data.toJson(), postId: postId.collection!.first.id);
    result.fold((l) => emit(AddReactError()), (r) {
      final reactions = Summary.fromJson(data.toJson());
      emit(AddReactSuccess(reactions: reactions));
    });
  }
}
