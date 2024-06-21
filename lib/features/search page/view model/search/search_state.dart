part of 'search_cubit.dart';

sealed class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

final class SearchInitial extends SearchState {}

final class SearchByUserLoading extends SearchState {}

final class SearchByUserSuccess extends SearchState {
  final UserList users;
  const SearchByUserSuccess({required this.users});
}

final class SearchByUserError extends SearchState {}

// ------------- //

final class SearchByGroupLoading extends SearchState {}

final class SearchByGroupSuccess extends SearchState {
  final UserList users;
  const SearchByGroupSuccess({required this.users});
}

final class SearchByGroupError extends SearchState {}
// ------------- //

final class SearchByPageLoading extends SearchState {}

final class SearchByPageSuccess extends SearchState {
  final UserList users;
  const SearchByPageSuccess({required this.users});
}

final class SearchByPageError extends SearchState {}
