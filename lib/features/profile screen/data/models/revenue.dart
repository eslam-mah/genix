class Revenue {
  int? total;
  List<dynamic>? top;

  Revenue({this.total, this.top});

  Revenue.fromJson(Map<String, dynamic> json)
      : total = json['total'],
        top = json['top'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['top'] = this.top;
    return data;
  }
}
