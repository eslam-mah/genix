class VideosModel {
  int id;
  String file;
  String fileUrl;
  String filename;
  String type;
  int size;
  List<AuxModel> aux;

  VideosModel({
    required this.id,
    required this.file,
    required this.fileUrl,
    required this.filename,
    required this.type,
    required this.size,
    required this.aux,
  });

  factory VideosModel.fromJson(Map<String, dynamic> json) {
    return VideosModel(
      id: json['id'] ?? 0,
      file: json['file'] ?? '',
      fileUrl: json['file_url'] ?? '',
      filename: json['filename'] ?? '',
      type: json['type'] ?? '',
      size: json['size'] ?? 0,
      aux: (json['aux'] as List<dynamic>)
          .map((item) => AuxModel.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['file'] = this.file;
    data['file_url'] = this.fileUrl;
    data['filename'] = this.filename;
    data['type'] = this.type;
    data['size'] = this.size;
    data['aux'] = this.aux.map((item) => item.toJson()).toList();
    return data;
  }
}

class AuxModel {
  String type;
  UploadModel upload;

  AuxModel({
    required this.type,
    required this.upload,
  });

  factory AuxModel.fromJson(Map<String, dynamic> json) {
    return AuxModel(
      type: json['type'] ?? '',
      upload: UploadModel.fromJson(json['upload']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = this.type;
    data['upload'] = this.upload.toJson();
    return data;
  }
}

class UploadModel {
  int id;
  String file;
  String fileUrl;
  String filename;
  String type;
  int size;

  UploadModel({
    required this.id,
    required this.file,
    required this.fileUrl,
    required this.filename,
    required this.type,
    required this.size,
  });

  factory UploadModel.fromJson(Map<String, dynamic> json) {
    return UploadModel(
      id: json['id'] ?? 0,
      file: json['file'] ?? '',
      fileUrl: json['file_url'] ?? '',
      filename: json['filename'] ?? '',
      type: json['type'] ?? '',
      size: json['size'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['file'] = this.file;
    data['file_url'] = this.fileUrl;
    data['filename'] = this.filename;
    data['type'] = this.type;
    data['size'] = this.size;
    return data;
  }
}
