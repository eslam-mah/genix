import 'package:genix/features/notifications%20screen/data/models/notifications_model.dart';

class NotificationsList {
  String status;
  Data data;

  NotificationsList({required this.status, required this.data});

  factory NotificationsList.fromJson(Map<String, dynamic> json) {
    return NotificationsList(
      status: json['status'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['data'] = this.data.toJson();
    return data;
  }
}

class Data {
  List<NotificationModel> notifications;
  Pagination pagination;

  Data({required this.notifications, required this.pagination});

  factory Data.fromJson(Map<String, dynamic> json) {
    var notificationsJson = json['collection'] as List;
    List<NotificationModel> notificationsList =
        notificationsJson.map((i) => NotificationModel.fromJson(i)).toList();

    return Data(
      notifications: notificationsList,
      pagination: Pagination.fromJson(json['pagination']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] = this
        .notifications
        .map((notificationModel) => notificationModel.toJson())
        .toList();
    data['pagination'] = this.pagination.toJson();
    return data;
  }

  void addNotification({required NotificationModel notification}) {
    this.notifications.add(notification);
  }

  void updateNotification({required NotificationModel newNotification}) {
    final updatedNotificationIndex = this.notifications.indexWhere(
        (n) => n.collection.first.id == newNotification.collection.first.id);
    if (updatedNotificationIndex != -1) {
      this.notifications[updatedNotificationIndex] = newNotification;
    }
  }

  void deleteNotification(String notificationId) {
    final removedNotificationIndex = this
        .notifications
        .indexWhere((n) => n.collection.first.id == notificationId);
    if (removedNotificationIndex != -1) {
      this.notifications.removeAt(removedNotificationIndex);
    }
  }
}
