class NotificationModel {
  List<Collection> collection;
  Pagination? pagination;

  NotificationModel({required this.collection, this.pagination});

  NotificationModel.fromJson(Map<String, dynamic> json)
      : collection = json['collection'] != null
            ? List<Collection>.from(
                json['collection'].map((v) => Collection.fromJson(v)))
            : [],
        pagination = json['pagination'] != null
            ? Pagination.fromJson(json['pagination'])
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] = this.collection.map((v) => v.toJson()).toList();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Collection {
  String id;
  Data? data;
  String? readAt;
  String? createdAt;

  Collection({required this.id, this.data, this.readAt, this.createdAt});

  Collection.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        data = json['data'] != null ? Data.fromJson(json['data']) : null,
        readAt = json['read_at'],
        createdAt = json['created_at'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['read_at'] = this.readAt;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class Data {
  String? content;
  String? thumbnail;
  String? link;
  String? reactionType;

  Data({this.content, this.thumbnail, this.link, this.reactionType});

  Data.fromJson(Map<String, dynamic> json)
      : content = json['content'],
        thumbnail = json['thumbnail'],
        link = json['link'],
        reactionType = json['reaction_type'];

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
  int? currentPage;
  int? from;
  int? lastPage;
  int? perPage;
  int? to;
  int? total;

  Pagination(
      {this.currentPage,
      this.from,
      this.lastPage,
      this.perPage,
      this.to,
      this.total});

  Pagination.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'],
        from = json['from'],
        lastPage = json['last_page'],
        perPage = json['per_page'],
        to = json['to'],
        total = json['total'];

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
