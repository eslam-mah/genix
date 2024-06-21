import 'member.dart';

class Me {
  Member? member;
  bool? manager;

  Me({this.member, this.manager});

  Me.fromJson(Map<String, dynamic> json)
      : member =
            json['member'] != null ? Member.fromJson(json['member']) : null,
        manager = json['manager'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['member'] = this.member?.toJson();
    data['manager'] = this.manager;
    return data;
  }
}
