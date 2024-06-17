part of 'first_load_cubit.dart';

@immutable
sealed class FirstLoadState {}

final class FirstLoadInitial extends FirstLoadState {}

final class FirstLoadLoading extends FirstLoadState {}

final class FirstLoadSuccess extends FirstLoadState {
  final ValidationModel firstLoad;
  FirstLoadSuccess({required this.firstLoad});
}

final class FirstLoadError extends FirstLoadState {}
