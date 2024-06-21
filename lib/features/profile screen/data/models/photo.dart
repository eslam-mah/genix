class Photo {
  int? id;
  String? filename;
  String? fileUrl;

  Photo({this.id, this.filename, this.fileUrl});

  Photo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        filename = json['filename'],
        fileUrl = json['file_url'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['filename'] = this.filename;
    data['file_url'] = this.fileUrl;
    return data;
  }
}
