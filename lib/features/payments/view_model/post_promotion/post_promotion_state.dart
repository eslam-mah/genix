part of 'post_promotion_cubit.dart';

sealed class PostPromotionState extends Equatable {
  const PostPromotionState();

  @override
  List<Object> get props => [];
}

final class PostPromotionInitial extends PostPromotionState {}

final class PostPromotionLoading extends PostPromotionState {}

final class PostPromotionSuccess extends PostPromotionState {
  final PromotionForm promotion;

  const PostPromotionSuccess({required this.promotion});
}

final class PostPromotionError extends PostPromotionState {}
