part of 'update_status_cubit.dart';

sealed class UpdateStatusState extends Equatable {
  const UpdateStatusState();

  @override
  List<Object> get props => [];
}

final class UpdateStatusInitial extends UpdateStatusState {}

final class UpdateStatusLoading extends UpdateStatusState {}

final class UpdateStatusSuccess extends UpdateStatusState {
  final SettingsModel status;
  const UpdateStatusSuccess({required this.status});
}

final class UpdateStatusError extends UpdateStatusState {}
