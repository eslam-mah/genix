part of 'remove_react_cubit.dart';

sealed class RemoveReactState extends Equatable {
  const RemoveReactState();

  @override
  List<Object> get props => [];
}

final class RemoveReactInitial extends RemoveReactState {}

final class RemoveReactLoading extends RemoveReactState {}

final class RemoveReactSuccess extends RemoveReactState {
  final String message;

  const RemoveReactSuccess({required this.message});
}

final class RemoveReactError extends RemoveReactState {}
