part of 'get_saved_shorts_cubit.dart';

sealed class GetSavedShortsState extends Equatable {
  const GetSavedShortsState();

  @override
  List<Object> get props => [];
}

final class GetSavedShortsInitial extends GetSavedShortsState {}

final class GetSavedShortsLoading extends GetSavedShortsState {}

final class GetSavedShortsSuccess extends GetSavedShortsState {
  final ShortsList shorts;
  const GetSavedShortsSuccess({required this.shorts});
}

final class GetSavedShortsError extends GetSavedShortsState {}
