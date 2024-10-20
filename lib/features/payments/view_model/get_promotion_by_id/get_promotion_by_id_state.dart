part of 'get_promotion_by_id_cubit.dart';

sealed class GetPromotionByIdState extends Equatable {
  const GetPromotionByIdState();

  @override
  List<Object> get props => [];
}

final class GetPromotionByIdInitial extends GetPromotionByIdState {}

final class GetPromotionByIdLoading extends GetPromotionByIdState {}

final class GetPromotionByIdSuccess extends GetPromotionByIdState {
  final PromotionsModel promotion;
  const GetPromotionByIdSuccess({required this.promotion});
}

final class GetPromotionByIdError extends GetPromotionByIdState {}
