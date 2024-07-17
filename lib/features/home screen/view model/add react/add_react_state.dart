part of 'add_react_cubit.dart';

sealed class AddReactState extends Equatable {
  const AddReactState();

  @override
  List<Object> get props => [];
}

final class AddReactInitial extends AddReactState {}

final class AddReactLoading extends AddReactState {}

final class AddReactSuccess extends AddReactState {
  final Summary reactions;
  const AddReactSuccess({required this.reactions});
}

final class AddReactError extends AddReactState {}
