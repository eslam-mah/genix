import 'package:genix/features/groups%20page/data/models/groups_model.dart';

class GroupsList {
  bool success;
  GroupData data;
  String? message;

  GroupsList({
    required this.success,
    required this.data,
    this.message,
  });

  factory GroupsList.fromJson(Map<String, dynamic> json) {
    return GroupsList(
      success: json['success'],
      data: GroupData.fromJson(json['data']),
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

class GroupData {
  List<GroupsModel> collection;
  List<GroupsModel>? managed;
  List<GroupsModel>? suggested;

  GroupData({
    required this.collection,
    required this.managed,
    required this.suggested,
  });

  factory GroupData.fromJson(Map<String, dynamic> json) {
    return GroupData(
      collection: (json['collection'] as List<dynamic>)
          .map((item) => GroupsModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      managed: json['managed'] != null && json['managed'] is List<dynamic>
          ? (json['managed'] as List<dynamic>)
              .map((item) => GroupsModel.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
      suggested: json['suggested'] != null && json['suggested'] is List<dynamic>
          ? (json['suggested'] as List<dynamic>)
              .map((item) => GroupsModel.fromJson(item as Map<String, dynamic>))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] = this.collection.map((item) => item.toJson()).toList();
    data['managed'] = this.managed?.map((item) => item.toJson()).toList();
    data['suggested'] = this.suggested?.map((item) => item.toJson()).toList();
    return data;
  }
}
