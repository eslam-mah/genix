import 'summary.dart';

class Reactions {
  Summary? summary;
  dynamic byMe;

  Reactions({this.summary, this.byMe});

  Reactions.fromJson(Map<String, dynamic> json)
      : summary =
            json['summary'] != null ? Summary.fromJson(json['summary']) : null,
        byMe = json['by_me'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['summary'] = this.summary?.toJson();
    data['by_me'] = this.byMe;
    return data;
  }
}
