part of 'update_my_account_cubit.dart';

sealed class UpdateMyAccountState extends Equatable {
  const UpdateMyAccountState();

  @override
  List<Object> get props => [];
}

final class UpdateMyAccountInitial extends UpdateMyAccountState {}

final class UpdateMyAccountLoading extends UpdateMyAccountState {}

final class UpdateMyAccountSuccess extends UpdateMyAccountState {
  final Map<String, dynamic> setting;
  const UpdateMyAccountSuccess({required this.setting});
}

final class UpdateMyAccountError extends UpdateMyAccountState {}
