part of 'add_poll_post_cubit.dart';

sealed class AddPollPostState extends Equatable {
  const AddPollPostState();

  @override
  List<Object> get props => [];
}

final class AddPollPostInitial extends AddPollPostState {}

final class AddPollPostLoading extends AddPollPostState {}

final class AddPollPostSuccess extends AddPollPostState {
  final PostForm post;
  const AddPollPostSuccess({required this.post});
}

final class AddPollPostError extends AddPollPostState {}
