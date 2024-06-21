class DocumentModel {
  List<Collection> collection;
  Pagination? pagination;

  DocumentModel({required this.collection, this.pagination});

  DocumentModel.fromJson(Map<String, dynamic> json)
      : collection = json['collection'](json['collection'] as List)
            .map((v) => Collection.fromJson(v))
            .toList(),
        pagination = json['pagination'] != null
            ? Pagination.fromJson(json['pagination'])
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['collection'] = this.collection?.map((v) => v.toJson()).toList();
    data['pagination'] = this.pagination?.toJson();
    return data;
  }
}

class Collection {
  int? id;
  String title;
  String? type;
  String? range;
  String? slug;
  String? content;
  String? createdAt;
  String? updatedAt;

  Collection({
    this.id,
    required this.title,
    this.type,
    this.range,
    this.slug,
    this.content,
    this.createdAt,
    this.updatedAt,
  });

  Collection.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        type = json['type'],
        range = json['range'],
        slug = json['slug'],
        content = json['content'],
        createdAt = json['created_at'],
        updatedAt = json['updated_at'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['type'] = this.type;
    data['range'] = this.range;
    data['slug'] = this.slug;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
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

  Pagination({
    this.currentPage,
    this.from,
    this.lastPage,
    this.perPage,
    this.to,
    this.total,
  });

  Pagination.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'],
        from = json['from'],
        lastPage = json['last_page'],
        perPage = json['per_page'],
        to = json['to'],
        total = json['total'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}
