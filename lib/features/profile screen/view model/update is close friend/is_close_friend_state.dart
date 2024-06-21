part of 'is_close_friend_cubit.dart';

sealed class IsCloseFriendState extends Equatable {
  const IsCloseFriendState();

  @override
  List<Object> get props => [];
}

final class IsCloseFriendInitial extends IsCloseFriendState {}

final class IsCloseFriendLoading extends IsCloseFriendState {}

final class IsCloseFriendSuccess extends IsCloseFriendState {
  final ProfileModel profile;
  const IsCloseFriendSuccess({required this.profile});
}

final class IsCloseFriendError extends IsCloseFriendState {}
