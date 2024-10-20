class Upload {
  int id;
  String file;
  String fileUrl;
  String filename;
  String extension;
  String type;
  int size;
  String createdAt;

  Upload({
    required this.id,
    required this.file,
    required this.fileUrl,
    required this.filename,
    required this.extension,
    required this.type,
    required this.size,
    required this.createdAt,
  });

  factory Upload.fromJson(Map<String, dynamic> json) {
    return Upload(
      id: json['id'] ?? 0,
      file: json['file'] ?? '',
      fileUrl: json['file_url'] ?? '',
      filename: json['filename'] ?? '',
      extension: json['extension'] ?? '',
      type: json['type'] ?? '',
      size: json['size'] ?? 0,
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['file'] = this.file;
    data['file_url'] = this.fileUrl;
    data['filename'] = this.filename;
    data['extension'] = this.extension;
    data['type'] = this.type;
    data['size'] = this.size;
    data['created_at'] = this.createdAt;
    return data;
  }
}
