class Misc {
  String? orientation;

  Misc({this.orientation});

  Misc.fromJson(Map<String, dynamic> json) : orientation = json['orientation'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orientation'] = this.orientation;
    return data;
  }
}
