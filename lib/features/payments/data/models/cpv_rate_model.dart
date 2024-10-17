class CpvModel {
  bool success;
  int data;
  String? message;

  CpvModel({
    required this.success,
    required this.data,
    this.message,
  });

  factory CpvModel.fromJson(Map<String, dynamic> json) {
    return CpvModel(
      success: json['success'] ?? false,
      data: json['data'] ?? 0,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    data['data'] = this.data;
    data['message'] = this.message;
    return data;
  }
}
