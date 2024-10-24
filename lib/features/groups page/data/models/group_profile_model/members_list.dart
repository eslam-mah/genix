import 'package:genix/features/groups%20page/data/models/group_profile_model/group.dart';
import 'package:genix/features/groups%20page/data/models/group_profile_model/member.dart';
import 'package:genix/features/groups%20page/data/models/group_profile_model/pagination.dart';

class MembersList {
  bool success;
  MembersData data;
  String? message;

  MembersList({
    required this.success,
    required this.data,
    this.message,
  });

  factory MembersList.fromJson(Map<String, dynamic> json) {
    return MembersList(
      success: json['success'],
      data: MembersData.fromJson(json['data']),
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    data['data'] = this.data.toJson();
    data['message'] = this.message;
    return data;
  }
}

class MembersData {
  List<Member> collection;
  Pagination pagination;
  Group group;

  MembersData({
    required this.collection,
    required this.pagination,
    required this.group,
  });

  factory MembersData.fromJson(Map<String, dynamic> json) {
    return MembersData(
      collection: (json['collection'] as List<dynamic>)
          .map((item) => Member.fromJson(item as Map<String, dynamic>))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
      group: Group.fromJson(json['group']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] = this.collection.map((item) => item.toJson()).toList();
    data['pagination'] = this.pagination.toJson();
    data['group'] = this.group.toJson();
    return data;
  }
}
