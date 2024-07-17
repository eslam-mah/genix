part of 'get_stories_cubit.dart';

sealed class GetStoriesState extends Equatable {
  const GetStoriesState();

  @override
  List<Object> get props => [];
}

final class GetStoriesInitial extends GetStoriesState {}

final class GetStoriesLoading extends GetStoriesState {}

final class GetStoriesSuccess extends GetStoriesState {
  final PostsList stories;
  const GetStoriesSuccess({required this.stories});
}

final class GetStoriesError extends GetStoriesState {}
