part of 'update_general_settings_cubit.dart';

sealed class UpdateGeneralSettingsState extends Equatable {
  const UpdateGeneralSettingsState();

  @override
  List<Object> get props => [];
}

final class UpdateGeneralSettingsInitial extends UpdateGeneralSettingsState {}

final class UpdateGeneralSettingsLoading extends UpdateGeneralSettingsState {}

final class UpdateGeneralSettingsSuccess extends UpdateGeneralSettingsState {
  final SettingsModel setting;
  const UpdateGeneralSettingsSuccess({required this.setting});
}

final class UpdateGeneralSettingsError extends UpdateGeneralSettingsState {}
