part of 'add_story_react_cubit.dart';

sealed class AddStoryReactState extends Equatable {
  const AddStoryReactState();

  @override
  List<Object> get props => [];
}

final class AddStoryReactInitial extends AddStoryReactState {}

final class AddStoryReactLoading extends AddStoryReactState {}

final class AddStoryReactSuccess extends AddStoryReactState {
  final PostsModel reactionType;

  const AddStoryReactSuccess({required this.reactionType});

  @override
  List<Object> get props => [reactionType];
}

final class AddStoryReactError extends AddStoryReactState {}
