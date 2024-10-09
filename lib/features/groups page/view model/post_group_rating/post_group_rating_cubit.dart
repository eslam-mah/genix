import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:genix/features/groups%20page/data/models/groups_model.dart';
import 'package:genix/features/groups%20page/data/repos/groups_repository.dart';

part 'post_group_rating_state.dart';

class PostGroupRatingCubit extends Cubit<PostGroupRatingState> {
  PostGroupRatingCubit() : super(PostGroupRatingInitial());
  final GroupsRepository groupsRepository = GroupsRepository();
  Future<void> postGroupRating(
      {required GroupsModel data, required int id}) async {
    emit(PostGroupRatingLoading());
    final result =
        await groupsRepository.postGroupRating(data: data.toJson(), id: id);
    result.fold(
      (l) => emit(PostGroupRatingError()),
      (r) {
        final rating = GroupsModel.fromJson(data.toJson());
        emit(PostGroupRatingSuccess(rating: rating));
      },
    );
  }
}
