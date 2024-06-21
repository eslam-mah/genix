class Saves {
  int? count;
  bool? byMe;

  Saves({this.count, this.byMe});

  Saves.fromJson(Map<String, dynamic> json)
      : count = json['count'],
        byMe = json['by_me'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['by_me'] = this.byMe;
    return data;
  }
}
