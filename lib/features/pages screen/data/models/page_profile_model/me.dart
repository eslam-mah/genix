import 'member.dart';

class Me {
  Member? member;
  bool? manager;

  Me({this.member, this.manager});

  factory Me.fromJson(Map<String, dynamic> json) => Me(
        member: json['member'] == null
            ? null
            : Member.fromJson(json['member'] as Map<String, dynamic>),
        manager: json['manager'] as bool?,
      );

  Map<String, dynamic> toJson() => {
        'member': member?.toJson(),
        'manager': manager,
      };
}
