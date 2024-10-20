class PhotosModel {
  int id;
  String file;
  String fileUrl;
  String filename;
  String type;
  int size;

  PhotosModel({
    required this.id,
    required this.file,
    required this.fileUrl,
    required this.filename,
    required this.type,
    required this.size,
  });

  factory PhotosModel.fromJson(Map<String, dynamic> json) {
    return PhotosModel(
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

class UserModel {
  int id;
  String username;
  String showname;
  String profileImg;
  String? coverImg;
  bool isVerified;
  String createdAt;
  bool isActive;
  int status;

  UserModel({
    required this.id,
    required this.username,
    required this.showname,
    required this.profileImg,
    this.coverImg,
    required this.isVerified,
    required this.createdAt,
    required this.isActive,
    required this.status,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      showname: json['showname'] ?? '',
      profileImg: json['profile_img'] ?? '',
      coverImg: json['cover_img'],
      isVerified: json['is_verified'] ?? false,
      createdAt: json['created_at'] ?? '',
      isActive: json['is_active'] ?? false,
      status: json['status'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['username'] = this.username;
    data['showname'] = this.showname;
    data['profile_img'] = this.profileImg;
    data['cover_img'] = this.coverImg;
    data['is_verified'] = this.isVerified;
    data['created_at'] = this.createdAt;
    data['is_active'] = this.isActive;
    data['status'] = this.status;
    return data;
  }
}
