class NotificationsModel {
  String id;
  NotificationDataContent data;
  String? readAt;
  String createdAt;

  NotificationsModel({
    required this.id,
    required this.data,
    this.readAt,
    required this.createdAt,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
      id: json['id'],
      data: NotificationDataContent.fromJson(json['data']),
      readAt: json['read_at'],
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['data'] = this.data.toJson();
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class NotificationDataContent {
  String content;
  String thumbnail;
  String link;
  String? reactionType;

  NotificationDataContent({
    required this.content,
    required this.thumbnail,
    required this.link,
    this.reactionType,
  });

  factory NotificationDataContent.fromJson(Map<String, dynamic> json) {
    return NotificationDataContent(
      content: json['content'],
      thumbnail: json['thumbnail'],
      link: json['link'],
      reactionType: json['reaction_type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['content'] = this.content;
    data['thumbnail'] = this.thumbnail;
    data['link'] = this.link;
    data['reaction_type'] = this.reactionType;
    return data;
  }
}

class Pagination {
  int currentPage;
  int from;
  int lastPage;
  int perPage;
  int to;
  int total;

  Pagination({
    required this.currentPage,
    required this.from,
    required this.lastPage,
    required this.perPage,
    required this.to,
    required this.total,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      currentPage: json['current_page'],
      from: json['from'],
      lastPage: json['last_page'],
      perPage: json['per_page'],
      to: json['to'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}
