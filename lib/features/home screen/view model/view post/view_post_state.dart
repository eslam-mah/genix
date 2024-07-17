part of 'view_post_cubit.dart';

sealed class ViewPostState extends Equatable {
  const ViewPostState();

  @override
  List<Object> get props => [];
}

final class ViewPostInitial extends ViewPostState {}

final class ViewPostLoading extends ViewPostState {}

final class ViewPostSuccess extends ViewPostState {
  final PostForm viewPost;
  const ViewPostSuccess({required this.viewPost});
}

final class ViewPostError extends ViewPostState {}
