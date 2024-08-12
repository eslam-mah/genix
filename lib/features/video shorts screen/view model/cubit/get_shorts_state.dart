part of 'get_shorts_cubit.dart';

sealed class GetShortsState extends Equatable {
  const GetShortsState();

  @override
  List<Object> get props => [];
}

final class GetShortsInitial extends GetShortsState {}

final class GetShortsLoading extends GetShortsState {}

final class GetShortsSuccess extends GetShortsState {
  final ShortsList shorts;
  const GetShortsSuccess({required this.shorts});
}

final class GetShortsError extends GetShortsState {}
