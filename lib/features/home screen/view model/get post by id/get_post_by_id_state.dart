part of 'get_post_by_id_cubit.dart';

sealed class GetPostByIdState extends Equatable {
  const GetPostByIdState();

  @override
  List<Object> get props => [];
}

final class GetPostByIdInitial extends GetPostByIdState {}

final class GetPostByIdLoading extends GetPostByIdState {}

final class GetPostByIdSuccess extends GetPostByIdState {
  final PostsList posts;
  const GetPostByIdSuccess({required this.posts});
}

final class GetPostByIdError extends GetPostByIdState {}
