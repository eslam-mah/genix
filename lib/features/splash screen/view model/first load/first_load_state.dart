part of 'first_load_cubit.dart';

@immutable
abstract class FirstLoadState extends Equatable {
  const FirstLoadState();

  @override
  List<Object?> get props => [];
}

class FirstLoadInitial extends FirstLoadState {}

class FirstLoadLoading extends FirstLoadState {}

class FirstLoadSuccess extends FirstLoadState {
  final ValidationModel firstLoad;
  final HttpResponseStatus status; // Use the enum here

  const FirstLoadSuccess({required this.firstLoad, required this.status});

  @override
  List<Object?> get props => [firstLoad, status];
}

class FirstLoadError extends FirstLoadState {
  final String? message;
  final HttpResponseStatus status; // Use the enum here

  const FirstLoadError({this.message, required this.status});

  @override
  List<Object?> get props => [message, status];
}
