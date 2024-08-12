part of 'get_posted_shorts_cubit.dart';

sealed class GetPostedShortsState extends Equatable {
  const GetPostedShortsState();

  @override
  List<Object> get props => [];
}

final class GetPostedShortsInitial extends GetPostedShortsState {}

final class GetPostedShortsLoading extends GetPostedShortsState {}

final class GetPostedShortsSuccess extends GetPostedShortsState {
  final ShortsList shorts;
  const GetPostedShortsSuccess({required this.shorts});
}

final class GetPostedShortsError extends GetPostedShortsState {}
