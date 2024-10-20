import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:genix/features/faqs%20and%20help%20screen/data/models/documents_list.dart';
import 'package:genix/features/faqs%20and%20help%20screen/data/repos/faqs_repository.dart';

part 'get_documents_by_id_state.dart';

class GetDocumentsByIdCubit extends Cubit<GetDocumentsByIdState> {
  GetDocumentsByIdCubit() : super(GetDocumentsByIdInitial());
  final FaqsRepository getDocumentsByIdRepo = FaqsRepository();
  Future<void> getDocumentsById({required String id}) async {
    emit(GetDocumentsByIdLoading());
    final result = await getDocumentsByIdRepo.getDocumentsById(id: id);
    result.fold((l) => emit(GetDocumentsByIdError()), (r) {
      final documents = DocumentsList.fromJson(r as Map<String, dynamic>);
      emit(GetDocumentsByIdSuccess(documents: documents));
    });
  }
}
