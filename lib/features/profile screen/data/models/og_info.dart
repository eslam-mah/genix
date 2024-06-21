class OgInfo {
  int? id;
  String? siteName;
  String? title;
  String? url;
  String? image;

  OgInfo({this.id, this.siteName, this.title, this.url, this.image});

  OgInfo.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        siteName = json['site_name'],
        title = json['title'],
        url = json['url'],
        image = json['image'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['site_name'] = this.siteName;
    data['title'] = this.title;
    data['url'] = this.url;
    data['image'] = this.image;
    return data;
  }
}
