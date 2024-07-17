part of 'get_video_posts_cubit.dart';

sealed class GetVideoPostsState extends Equatable {
  const GetVideoPostsState();

  @override
  List<Object> get props => [];
}

final class GetVideoPostsInitial extends GetVideoPostsState {}

final class GetVideoPostsLoading extends GetVideoPostsState {}

final class GetVideoPostsSuccess extends GetVideoPostsState {
  final PostsList videoPosts;
  const GetVideoPostsSuccess({required this.videoPosts});
}

final class GetVideoPostsError extends GetVideoPostsState {}
