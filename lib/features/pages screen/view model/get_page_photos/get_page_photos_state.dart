part of 'get_page_photos_cubit.dart';

sealed class GetPagePhotosState extends Equatable {
  const GetPagePhotosState();

  @override
  List<Object> get props => [];
}

final class GetPagePhotosInitial extends GetPagePhotosState {}

final class GetPagePhotosLoading extends GetPagePhotosState {}

final class GetPagePhotosSuccess extends GetPagePhotosState {
  final PageProfileModel page;
  const GetPagePhotosSuccess({required this.page});
}

final class GetPagePhotosError extends GetPagePhotosState {}
