part of 'get_group_photos_cubit.dart';

sealed class GetGroupPhotosState extends Equatable {
  const GetGroupPhotosState();

  @override
  List<Object> get props => [];
}

final class GetGroupPhotosInitial extends GetGroupPhotosState {}

final class GetGroupPhotosLoading extends GetGroupPhotosState {}

final class GetGroupPhotosSuccess extends GetGroupPhotosState {
  final GroupProfileModel group;

  const GetGroupPhotosSuccess({required this.group});
}

final class GetGroupPhotosError extends GetGroupPhotosState {}
