part of 'see_story_cubit.dart';

sealed class SeeStoryState extends Equatable {
  const SeeStoryState();

  @override
  List<Object> get props => [];
}

final class SeeStoryInitial extends SeeStoryState {}

final class SeeStoryLoading extends SeeStoryState {}

final class SeeStorySuccess extends SeeStoryState {
  final StoryModel storyModel;
  const SeeStorySuccess({required this.storyModel});
}

final class SeeStoryError extends SeeStoryState {}
