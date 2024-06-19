part of 'update_my_emails_cubit.dart';

sealed class UpdateMyEmailsState extends Equatable {
  const UpdateMyEmailsState();

  @override
  List<Object> get props => [];
}

final class UpdateMyEmailsInitial extends UpdateMyEmailsState {}

final class UpdateMyEmailsLoading extends UpdateMyEmailsState {}

final class UpdateMyEmailsSuccess extends UpdateMyEmailsState {
  final SettingsModel setting;
  const UpdateMyEmailsSuccess({required this.setting});
}

final class UpdateMyEmailsError extends UpdateMyEmailsState {}
