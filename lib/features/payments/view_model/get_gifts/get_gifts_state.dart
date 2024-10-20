part of 'get_gifts_cubit.dart';

sealed class GetGiftsState extends Equatable {
  const GetGiftsState();

  @override
  List<Object> get props => [];
}

final class GetGiftsInitial extends GetGiftsState {}

final class GetGiftsLoading extends GetGiftsState {}

final class GetGiftsSuccess extends GetGiftsState {
  final GiftsList gifts;

  const GetGiftsSuccess({required this.gifts});
}

final class GetGiftsError extends GetGiftsState {}
