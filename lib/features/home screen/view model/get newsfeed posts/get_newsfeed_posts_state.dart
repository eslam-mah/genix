part of 'get_newsfeed_posts_cubit.dart';

sealed class GetNewsFeedPostsState extends Equatable {
  const GetNewsFeedPostsState();

  @override
  List<Object> get props => [];
}

final class GetNewsfeedPostsInitial extends GetNewsFeedPostsState {}

final class GetNewsFeedPostsLoading extends GetNewsFeedPostsState {}

final class GetNewsFeedPostsSuccess extends GetNewsFeedPostsState {
  final PostsList posts;
  const GetNewsFeedPostsSuccess({required this.posts});
}

final class GetNewsFeedPostsError extends GetNewsFeedPostsState {
  final String message;
  const GetNewsFeedPostsError({required this.message});
}
