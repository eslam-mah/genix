part of 'get_page_by_id_cubit.dart';

sealed class GetPageByIdState extends Equatable {
  const GetPageByIdState();

  @override
  List<Object> get props => [];
}

final class GetPageByIdInitial extends GetPageByIdState {}

final class GetPageByIdLoading extends GetPageByIdState {}

final class GetPageByIdSuccess extends GetPageByIdState {
  final PageProfileModel page;

  const GetPageByIdSuccess({required this.page});
}

final class GetPageByIdError extends GetPageByIdState {}
