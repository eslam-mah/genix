import 'summary.dart';

class Reactions {
  Summary? summary;
  dynamic byMe;

  Reactions({this.summary, this.byMe});

  Reactions.fromJson(Map<String, dynamic> json)
      : summary = json['summary'] != null
            ? Summary.fromJson(json['summary'] as Map<String, dynamic>)
            : null,
        byMe = json['by_me'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    data['by_me'] = byMe;
    return data;
  }
}
