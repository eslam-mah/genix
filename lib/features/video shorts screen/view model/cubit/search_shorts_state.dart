part of 'search_shorts_cubit.dart';

sealed class SearchShortsState extends Equatable {
  const SearchShortsState();

  @override
  List<Object> get props => [];
}

final class SearchShortsInitial extends SearchShortsState {}

final class SearchShortsLoading extends SearchShortsState {}

final class SearchShortsSuccess extends SearchShortsState {
  final ShortsModel short;
  const SearchShortsSuccess({required this.short});
}

final class SearchShortsError extends SearchShortsState {}
