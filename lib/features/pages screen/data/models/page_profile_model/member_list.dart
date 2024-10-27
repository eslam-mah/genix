import 'package:genix/features/pages%20screen/data/models/page_profile_model/member.dart';
import 'package:genix/features/pages%20screen/data/models/page_profile_model/page.dart';
import 'package:genix/features/pages%20screen/data/models/page_profile_model/pagination.dart';

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
  Page page;

  MembersData({
    required this.collection,
    required this.pagination,
    required this.page,
  });

  factory MembersData.fromJson(Map<String, dynamic> json) {
    return MembersData(
      collection: (json['collection'] as List<dynamic>)
          .map((item) => Member.fromJson(item as Map<String, dynamic>))
          .toList(),
      pagination: Pagination.fromJson(json['pagination']),
      page: Page.fromJson(json['page']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] = this.collection.map((item) => item.toJson()).toList();
    data['pagination'] = this.pagination.toJson();
    data['page'] = this.page.toJson();
    return data;
  }
}
