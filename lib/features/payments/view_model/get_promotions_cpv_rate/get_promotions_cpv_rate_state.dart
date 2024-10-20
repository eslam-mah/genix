part of 'get_promotions_cpv_rate_cubit.dart';

sealed class GetPromotionsCpvRateState extends Equatable {
  const GetPromotionsCpvRateState();

  @override
  List<Object> get props => [];
}

final class GetPromotionsCpvRateInitial extends GetPromotionsCpvRateState {}

final class GetPromotionsCpvRateLoading extends GetPromotionsCpvRateState {}

final class GetPromotionsCpvRateSuccess extends GetPromotionsCpvRateState {
  final CpvModel cpvRate;

  const GetPromotionsCpvRateSuccess({required this.cpvRate});
}

final class GetPromotionsCpvRateError extends GetPromotionsCpvRateState {}
