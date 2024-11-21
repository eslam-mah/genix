import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/followings%20list%20page/data/models/followings_list.dart';
import 'package:genix/features/followings%20list%20page/data/repos/followings_repository.dart';

part 'get_followings_state.dart';

class GetFollowingsCubit extends Cubit<GetFollowingsState> {
  GetFollowingsCubit() : super(GetFollowingsInitial());
  final FollowingsRepository getFollowingsRepo = FollowingsRepository();
  Future<void> getFollowings({required int id, int? page}) async {
    emit(GetFollowingsLoading());
    final result =
        await getFollowingsRepo.getFollowings(id: id, page: page ?? 1);
    result.fold((l) => emit(GetFollowingsError()), (r) {
      final followings = FollowingsList.fromJson(r as Map<String, dynamic>);
      emit(GetFollowingsSuccess(followings: followings));
    });
  }
}
