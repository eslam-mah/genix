class GiftsModel {
  int id;
  String name;
  int cost;
  String fileUrl;
  DateTime createdAt;

  GiftsModel({
    required this.id,
    required this.name,
    required this.cost,
    required this.fileUrl,
    required this.createdAt,
  });

  factory GiftsModel.fromJson(Map<String, dynamic> json) {
    return GiftsModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      cost: json['cost'] ?? 0,
      fileUrl: json['file_url'] ?? '',
      createdAt:
          DateTime.parse(json['created_at'] ?? DateTime.now().toString()),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = this.id;
    data['name'] = this.name;
    data['cost'] = this.cost;
    data['file_url'] = this.fileUrl;
    data['created_at'] = this.createdAt.toIso8601String();
    return data;
  }
}
