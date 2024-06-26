import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/followers%20list%20page/data/models/followers_list.dart';
import 'package:genix/features/followers%20list%20page/data/models/followers_model.dart';
import 'package:genix/features/followers%20list%20page/data/repos/followers_repository.dart';

part 'get_followers_state.dart';

class GetFollowersCubit extends Cubit<GetFollowersState> {
  GetFollowersCubit() : super(GetFollowersInitial());
  final FollowersRepository getFollowersRepo = FollowersRepository();
  Future<void> getFollowers({required FollowersModel id}) async {
    emit(GetFollowersLoading());
    final result = await getFollowersRepo.getFollowers(id: id.user.id);
    result.fold((l) => emit(GetFollowersError()), (r) {
      final followers = FollowersList.fromJson(r as Map<String, dynamic>);
      GetFollowersSuccess(followers: followers);
    });
  }
}
