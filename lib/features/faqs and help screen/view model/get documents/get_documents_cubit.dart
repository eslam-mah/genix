import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/faqs%20and%20help%20screen/data/models/documents_list.dart';
import 'package:genix/features/faqs%20and%20help%20screen/data/repos/faqs_repository.dart';

part 'get_documents_state.dart';

class GetDocumentsCubit extends Cubit<GetDocumentsState> {
  GetDocumentsCubit() : super(GetDocumentsInitial());
  final FaqsRepository getDocumentsRepo = FaqsRepository();
  Future<void> getDocuments() async {
    emit(GetDocumentsLoading());
    final result = await getDocumentsRepo.getAllDocuments();
    result.fold((l) => emit(GetDocumentsError()), (r) {
      final documents = DocumentsList.fromJson(r as Map<String, dynamic>);
      emit(GetDocumentsSuccess(documents: documents));
    });
  }
}
