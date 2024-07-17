part of 'get_timeline_posts_cubit.dart';

sealed class GetTimelinePostsState extends Equatable {
  const GetTimelinePostsState();

  @override
  List<Object> get props => [];
}

final class GetTimelinePostsInitial extends GetTimelinePostsState {}

final class GetTimelinePostsLoading extends GetTimelinePostsState {}

final class GetTimelinePostsSuccess extends GetTimelinePostsState {
  final PostsList posts;
  const GetTimelinePostsSuccess({required this.posts});
}

final class GetTimelinePostsError extends GetTimelinePostsState {}
