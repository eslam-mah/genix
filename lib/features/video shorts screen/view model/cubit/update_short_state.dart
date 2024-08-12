part of 'update_short_cubit.dart';

sealed class UpdateShortState extends Equatable {
  const UpdateShortState();

  @override
  List<Object> get props => [];
}

final class UpdateShortInitial extends UpdateShortState {}

final class UpdateShortLoading extends UpdateShortState {}

final class UpdateShortSuccess extends UpdateShortState {
  final ShortsModel short;
  const UpdateShortSuccess({required this.short});
}

final class UpdateShortError extends UpdateShortState {}
