part of 'get_followers_cubit.dart';

sealed class GetFollowersState extends Equatable {
  const GetFollowersState();

  @override
  List<Object> get props => [];
}

final class GetFollowersInitial extends GetFollowersState {}

final class GetFollowersLoading extends GetFollowersState {}

final class GetFollowersSuccess extends GetFollowersState {
  final FollowersList followers;
  const GetFollowersSuccess({required this.followers});
}

final class GetFollowersError extends GetFollowersState {}
