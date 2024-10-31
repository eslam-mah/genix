part of 'get_my_account_details_cubit.dart';

sealed class GetMyAccountDetailsState extends Equatable {
  const GetMyAccountDetailsState();

  @override
  List<Object> get props => [];
}

final class GetMyAccountDetailsInitial extends GetMyAccountDetailsState {}

final class GetMyAccountDetailsLoading extends GetMyAccountDetailsState {}

final class GetMyAccountDetailsSuccess extends GetMyAccountDetailsState {
  final SettingsModel account;
  const GetMyAccountDetailsSuccess({required this.account});
}

final class GetMyAccountDetailsError extends GetMyAccountDetailsState {
  final String message;

  const GetMyAccountDetailsError({required this.message});
}
