part of 'get_documents_cubit.dart';

sealed class GetDocumentsState extends Equatable {
  const GetDocumentsState();

  @override
  List<Object> get props => [];
}

final class GetDocumentsInitial extends GetDocumentsState {}

final class GetDocumentsLoading extends GetDocumentsState {}

final class GetDocumentsSuccess extends GetDocumentsState {
  final DocumentsList documents;
  const GetDocumentsSuccess({required this.documents});
}

final class GetDocumentsError extends GetDocumentsState {}
