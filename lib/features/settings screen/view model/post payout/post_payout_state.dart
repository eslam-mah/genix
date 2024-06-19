part of 'post_payout_cubit.dart';

sealed class PostPayoutState extends Equatable {
  const PostPayoutState();

  @override
  List<Object> get props => [];
}

final class PostPayoutInitial extends PostPayoutState {}
