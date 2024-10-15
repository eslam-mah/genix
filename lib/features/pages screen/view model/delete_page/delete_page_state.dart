part of 'delete_page_cubit.dart';

sealed class DeletePageState extends Equatable {
  const DeletePageState();

  @override
  List<Object> get props => [];
}

final class DeletePageInitial extends DeletePageState {}

final class DeletePageLoading extends DeletePageState {}

final class DeletePageSuccess extends DeletePageState {
  final int id;

  const DeletePageSuccess({required this.id});
}

final class DeletePageError extends DeletePageState {}
