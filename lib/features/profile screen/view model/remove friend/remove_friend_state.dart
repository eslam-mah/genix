part of 'remove_friend_cubit.dart';

sealed class RemoveFriendState extends Equatable {
  const RemoveFriendState();

  @override
  List<Object> get props => [];
}

final class RemoveFriendInitial extends RemoveFriendState {}

final class RemoveFriendLoading extends RemoveFriendState {}

final class RemoveFriendSuccess extends RemoveFriendState {
  final int uid;
  const RemoveFriendSuccess({required this.uid});
}

final class RemoveFriendError extends RemoveFriendState {}
