part of 'get_all_pages_cubit.dart';

sealed class GetAllPagesState extends Equatable {
  const GetAllPagesState();

  @override
  List<Object> get props => [];
}

final class GetAllPagesInitial extends GetAllPagesState {}

final class GetAllPagesLoading extends GetAllPagesState {}

final class GetAllPagesSuccess extends GetAllPagesState {
  final PagesList pages;

  const GetAllPagesSuccess({required this.pages});
}

final class GetAllPagesError extends GetAllPagesState {}
