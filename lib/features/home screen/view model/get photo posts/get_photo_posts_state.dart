part of 'get_photo_posts_cubit.dart';

sealed class GetPhotoPostsState extends Equatable {
  const GetPhotoPostsState();

  @override
  List<Object> get props => [];
}

final class GetPhotoPostsInitial extends GetPhotoPostsState {}

final class GetPhotoPostsLoading extends GetPhotoPostsState {}

final class GetPhotoPostsSuccess extends GetPhotoPostsState {
  final PostsList photoPosts;
  const GetPhotoPostsSuccess({required this.photoPosts});
}

final class GetPhotoPostsError extends GetPhotoPostsState {}
