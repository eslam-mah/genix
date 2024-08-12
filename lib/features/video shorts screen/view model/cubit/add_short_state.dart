part of 'add_short_cubit.dart';

sealed class AddShortState extends Equatable {
  const AddShortState();

  @override
  List<Object> get props => [];
}

final class AddShortInitial extends AddShortState {}

final class AddShortLoading extends AddShortState {}

final class AddShortSuccess extends AddShortState {
  final ShortsModel short;
  const AddShortSuccess({required this.short});
}

final class AddShortError extends AddShortState {}
