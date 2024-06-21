part of 'post_payout_cubit.dart';

sealed class PostPayoutState extends Equatable {
  const PostPayoutState();

  @override
  List<Object> get props => [];
}

final class PostPayoutInitial extends PostPayoutState {}

final class PostPayoutLoading extends PostPayoutState {}

final class PostPayoutSuccess extends PostPayoutState {
  final PayoutModel payout;
  const PostPayoutSuccess({required this.payout});
}

final class PostPayoutError extends PostPayoutState {}
