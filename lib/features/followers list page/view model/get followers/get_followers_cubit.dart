import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/followers%20list%20page/data/models/followers_list.dart';
import 'package:genix/features/followers%20list%20page/data/repos/followers_repository.dart';

part 'get_followers_state.dart';

class GetFollowersCubit extends Cubit<GetFollowersState> {
  GetFollowersCubit() : super(GetFollowersInitial());
  final FollowersRepository getFollowersRepo = FollowersRepository();
  Future<void> getFollowers({required int id, required int page}) async {
    emit(GetFollowersLoading());
    final result = await getFollowersRepo.getFollowers(id: id, page: page);
    result.fold((l) {
      emit(GetFollowersError());
    }, (r) {
      final followers = FollowersList.fromJson(r as Map<String, dynamic>);
      emit(GetFollowersSuccess(followers: followers));
    });
  }
}
