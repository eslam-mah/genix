import 'package:genix/features/notifications%20screen/data/models/notifications_model.dart';

class NotificationsList {
  bool success;
  NotificationData data;
  String? message;

  NotificationsList({required this.success, required this.data, this.message});

  factory NotificationsList.fromJson(Map<String, dynamic> json) {
    return NotificationsList(
      success: json['success'],
      data: NotificationData.fromJson(json['data']),
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

class NotificationData {
  List<NotificationsModel> collection;

  NotificationData({required this.collection});

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      collection: (json['collection'] as List)
          .map((item) => NotificationsModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] = this.collection.map((item) => item.toJson()).toList();

    return data;
  }
}
