part of 'get_newsfeed_posts_cubit.dart';

sealed class GetNewsfeedPostsState extends Equatable {
  const GetNewsfeedPostsState();

  @override
  List<Object> get props => [];
}

final class GetNewsfeedPostsInitial extends GetNewsfeedPostsState {}

final class GetNewsfeedPostsLoading extends GetNewsfeedPostsState {}

final class GetNewsfeedPostsSuccess extends GetNewsfeedPostsState {
  final PostsList posts;
  const GetNewsfeedPostsSuccess({required this.posts});
}

final class GetNewsfeedPostsError extends GetNewsfeedPostsState {}
