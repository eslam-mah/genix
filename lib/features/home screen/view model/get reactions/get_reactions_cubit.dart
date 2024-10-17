import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/reactions.dart';
import 'package:genix/features/home%20screen/data/repos/posts_repository.dart';

part 'get_reactions_state.dart';

class GetReactionsCubit extends Cubit<GetReactionsState> {
  GetReactionsCubit() : super(GetReactionsInitial());
  final PostsRepository getReactionsRepo = PostsRepository();
  Future<void> getReactions() async {
    emit(GetReactionsLoading());
    final result = await getReactionsRepo.getReactions();
    result.fold((l) => emit(GetReactionsError()), (r) {
      final reactions = Reactions.fromJson(r as Map<String, dynamic>);
      emit(GetReactionsSuccess(reactions: reactions));
    });
  }
}
