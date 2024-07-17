import 'package:genix/features/faqs%20and%20help%20screen/data/models/document_model.dart';

class DocumentsList {
  String status;
  DocumentData data;

  DocumentsList({required this.status, required this.data});

  factory DocumentsList.fromJson(Map<String, dynamic> json) {
    return DocumentsList(
      status: json['status'],
      data: DocumentData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['data'] = this.data.toJson();
    return data;
  }
}

class DocumentData {
  List<DocumentModel> documents;

  DocumentData({required this.documents});

  factory DocumentData.fromJson(Map<String, dynamic> json) {
    var documentsJson = json['collection'] as List;
    List<DocumentModel> documentList =
        documentsJson.map((i) => DocumentModel.fromJson(i)).toList();

    return DocumentData(
      documents: documentList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] =
        this.documents.map((documentModel) => documentModel.toJson()).toList();
    return data;
  }

  void addDocument({required DocumentModel document}) {
    this.documents.add(document);
  }

  void updateDocument({required DocumentModel newDocument}) {
    final updatedDocumentIndex = this.documents.indexWhere(
        (d) => d.collection.first.id == newDocument.collection.first.id);
    if (updatedDocumentIndex != -1) {
      this.documents[updatedDocumentIndex] = newDocument;
    }
  }

  void deleteDocument(int documentId) {
    final removedDocumentIndex =
        this.documents.indexWhere((d) => d.collection.first.id == documentId);
    if (removedDocumentIndex != -1) {
      this.documents.removeAt(removedDocumentIndex);
    }
  }
}
