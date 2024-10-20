import 'package:equatable/equatable.dart';
import 'package:genix/features/photos%20page/data/models/photos_list.dart';

sealed class GetPhotoPostsState extends Equatable {
  const GetPhotoPostsState();

  @override
  List<Object> get props => [];
}

final class GetPhotoPostsInitial extends GetPhotoPostsState {}

final class GetPhotoPostsLoading extends GetPhotoPostsState {}

final class GetPhotoPostsSuccess extends GetPhotoPostsState {
  final PhotosList photoPosts;
  const GetPhotoPostsSuccess({required this.photoPosts});
}

final class GetPhotoPostsError extends GetPhotoPostsState {}
