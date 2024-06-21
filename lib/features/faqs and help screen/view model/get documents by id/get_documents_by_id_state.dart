part of 'get_documents_by_id_cubit.dart';

sealed class GetDocumentsByIdState extends Equatable {
  const GetDocumentsByIdState();

  @override
  List<Object> get props => [];
}

final class GetDocumentsByIdInitial extends GetDocumentsByIdState {}

final class GetDocumentsByIdLoading extends GetDocumentsByIdState {}

final class GetDocumentsByIdSuccess extends GetDocumentsByIdState {
  final DocumentsList documents;
  const GetDocumentsByIdSuccess({required this.documents});
}

final class GetDocumentsByIdError extends GetDocumentsByIdState {}
