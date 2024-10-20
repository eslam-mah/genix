import 'package:equatable/equatable.dart';

class OgInfo extends Equatable {
  final int? id;
  final String? siteName;
  final String? title;
  final String? url;
  final String? image;

  const OgInfo({this.id, this.siteName, this.title, this.url, this.image});

  factory OgInfo.fromJson(Map<String, dynamic> json) => OgInfo(
        id: json['id'] as int?,
        siteName: json['site_name'] as String?,
        title: json['title'] as String?,
        url: json['url'] as String?,
        image: json['image'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'site_name': siteName,
        'title': title,
        'url': url,
        'image': image,
      };

  @override
  List<Object?> get props => [id, siteName, title, url, image];
}
