part of 'get_all_payouts_cubit.dart';

sealed class GetAllPayoutsState extends Equatable {
  const GetAllPayoutsState();

  @override
  List<Object> get props => [];
}

final class GetAllPayoutsInitial extends GetAllPayoutsState {}

final class GetAllPayoutsLoading extends GetAllPayoutsState {}

final class GetAllPayoutsSuccess extends GetAllPayoutsState {
  final PayoutModel payouts;
  const GetAllPayoutsSuccess({required this.payouts});
}

final class GetAllPayoutsError extends GetAllPayoutsState {}
