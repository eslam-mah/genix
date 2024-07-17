class OgInfo {
  int? id;
  String? siteName;
  String? title;
  String? url;
  String? image;

  OgInfo({
    this.id,
    this.siteName,
    this.title,
    this.url,
    this.image,
  });

  OgInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        siteName = json['site_name'] as String?,
        title = json['title'] as String?,
        url = json['url'] as String?,
        image = json['image'] as String?;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['site_name'] = siteName;
    data['title'] = title;
    data['url'] = url;
    data['image'] = image;
    return data;
  }
}
