part of 'get_promotions_cubit.dart';

sealed class GetPromotionsState extends Equatable {
  const GetPromotionsState();

  @override
  List<Object> get props => [];
}

final class GetPromotionsInitial extends GetPromotionsState {}

final class GetPromotionsLoading extends GetPromotionsState {}

final class GetPromotionsSuccess extends GetPromotionsState {
  final PromotionsList promotions;

  const GetPromotionsSuccess({required this.promotions});
}

final class GetPromotionsError extends GetPromotionsState {}
