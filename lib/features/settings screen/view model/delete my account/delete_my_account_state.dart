part of 'delete_my_account_cubit.dart';

sealed class DeleteMyAccountState extends Equatable {
  const DeleteMyAccountState();

  @override
  List<Object> get props => [];
}

final class DeleteMyAccountInitial extends DeleteMyAccountState {}

final class DeleteMyAccountLoading extends DeleteMyAccountState {}

final class DeleteMyAccountSuccess extends DeleteMyAccountState {
  final String account;
  const DeleteMyAccountSuccess({required this.account});
}

final class DeleteMyAccountError extends DeleteMyAccountState {}
