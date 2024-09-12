part of 'add_react_cubit.dart';

abstract class AddReactState extends Equatable {
  const AddReactState();

  @override
  List<Object> get props => [];
}

class AddReactInitial extends AddReactState {}

class AddReactLoading extends AddReactState {}

class AddReactSuccess extends AddReactState {
  final String reactionType;

  const AddReactSuccess({required this.reactionType});

  @override
  List<Object> get props => [reactionType];
}

class AddReactError extends AddReactState {}
