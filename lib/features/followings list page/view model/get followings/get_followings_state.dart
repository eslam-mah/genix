part of 'get_followings_cubit.dart';

sealed class GetFollowingsState extends Equatable {
  const GetFollowingsState();

  @override
  List<Object> get props => [];
}

final class GetFollowingsInitial extends GetFollowingsState {}

final class GetFollowingsLoading extends GetFollowingsState {}

final class GetFollowingsSuccess extends GetFollowingsState {
  final FollowingsList followings;
  const GetFollowingsSuccess({required this.followings});
}

final class GetFollowingsError extends GetFollowingsState {}
