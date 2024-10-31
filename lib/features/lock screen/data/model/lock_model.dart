class LockModel {
  final bool success;
  final bool data;
  final String? message;

  LockModel({
    required this.success,
    required this.data,
    this.message,
  });

  // Factory constructor to create a LockModel instance from JSON
  factory LockModel.fromJson(Map<String, dynamic> json) {
    return LockModel(
      success: json['success'],
      data: json['data'],
      message: json['message'],
    );
  }

  // Method to convert LockModel instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['success'] = success;
    json['data'] = data;
    json['message'] = message;
    return json;
  }
}
