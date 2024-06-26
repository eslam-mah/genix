import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/followings%20list%20page/data/models/followings_list.dart';
import 'package:genix/features/followings%20list%20page/data/models/followings_model.dart';
import 'package:genix/features/followings%20list%20page/data/repos/followings_repository.dart';

part 'get_followings_state.dart';

class GetFollowingsCubit extends Cubit<GetFollowingsState> {
  GetFollowingsCubit() : super(GetFollowingsInitial());
  final FollowingsRepository getFollowingsRepo = FollowingsRepository();
  Future<void> getFollowings({required FollowingsModel id}) async {
    emit(GetFollowingsLoading());
    final result = await getFollowingsRepo.getFollowings(id: id.user.id);
    result.fold((l) => emit(GetFollowingsError()), (r) {
      final followings = FollowingsList.fromJson(r as Map<String, dynamic>);
      GetFollowingsSuccess(followings: followings);
    });
  }
}
