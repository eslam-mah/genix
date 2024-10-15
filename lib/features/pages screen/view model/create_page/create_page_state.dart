part of 'create_page_cubit.dart';

sealed class CreatePageState extends Equatable {
  const CreatePageState();

  @override
  List<Object> get props => [];
}

final class CreatePageInitial extends CreatePageState {}

final class CreatePageLoading extends CreatePageState {}

final class CreatePageSuccess extends CreatePageState {
  final Map<String, dynamic> data;

  const CreatePageSuccess({required this.data});
}

final class CreatePageError extends CreatePageState {}
