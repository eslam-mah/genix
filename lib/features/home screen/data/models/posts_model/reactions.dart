import 'summary.dart';

class Reactions {
  Summary? summary;
  dynamic byMe;

  Reactions({this.summary, this.byMe});

  Reactions.fromJson(Map<String, dynamic> json)
      : summary =
            json['summary'] != null && json['summary'] is Map<String, dynamic>
                ? Summary.fromJson(json['summary'] as Map<String, dynamic>)
                : null,
        byMe = json['by_me'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (summary != null) {
      data['summary'] = summary!.toJson();
    }
    data['by_me'] = byMe;
    return data;
  }
}
