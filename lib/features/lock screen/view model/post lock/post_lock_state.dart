part of 'post_lock_cubit.dart';

sealed class PostLockState extends Equatable {
  const PostLockState();

  @override
  List<Object> get props => [];
}

final class PostLockInitial extends PostLockState {}

final class PostLockLoading extends PostLockState {}

final class PostLockSuccess extends PostLockState {
  final Map<dynamic, dynamic> data;
  const PostLockSuccess({required this.data});
}

final class PostLockError extends PostLockState {}
