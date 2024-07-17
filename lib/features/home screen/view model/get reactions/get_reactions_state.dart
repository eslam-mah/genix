part of 'get_reactions_cubit.dart';

sealed class GetReactionsState extends Equatable {
  const GetReactionsState();

  @override
  List<Object> get props => [];
}

final class GetReactionsInitial extends GetReactionsState {}

final class GetReactionsLoading extends GetReactionsState {}

final class GetReactionsSuccess extends GetReactionsState {
  final Reactions reactions;
  const GetReactionsSuccess({required this.reactions});
}

final class GetReactionsError extends GetReactionsState {}
