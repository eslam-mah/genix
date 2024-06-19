part of 'get_all_payouts_cubit.dart';

sealed class GetAllPayoutsState extends Equatable {
  const GetAllPayoutsState();

  @override
  List<Object> get props => [];
}

final class GetAllPayoutsInitial extends GetAllPayoutsState {}
