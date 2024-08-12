import 'package:equatable/equatable.dart';

class Photo extends Equatable {
  final int? id;
  final String? filename;
  final String? fileUrl;

  const Photo({this.id, this.filename, this.fileUrl});

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json['id'] as int?,
        filename: json['filename'] as String?,
        fileUrl: json['file_url'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'filename': filename,
        'file_url': fileUrl,
      };

  @override
  List<Object?> get props => [id, filename, fileUrl];
}
