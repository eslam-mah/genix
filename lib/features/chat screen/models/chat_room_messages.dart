import '../../profile screen/data/profile_model/user.dart';

class ChatRoomMessagesResponse {
  final bool? success;
  final Data? data;
  final String? message;

  ChatRoomMessagesResponse({this.success, this.data, this.message});

  factory ChatRoomMessagesResponse.fromJson(Map<String, dynamic> json) {
    return ChatRoomMessagesResponse(
      success: json['success'],
      data: json['data'] != null ? Data.fromJson(json['data']) : null,
      message: json['message'],
    );
  }
}

class Data {
  final List<Message>? messages;
  final Pagination? pagination;

  Data({this.messages, this.pagination});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      messages: json['collection'] != null ? (json['collection'] as List).map((i) => Message.fromJson(i)).toList() : null,
      pagination: json['pagination'] != null ? Pagination.fromJson(json['pagination']) : null,
    );
  }
}

class Message {
  final int? id;
  final int? roomId;
  final User? user;
  final String? content;
  final List<Upload>? uploads;
  final bool? isProcessing;
  final bool? isNotification;
  final String? createdAt;

  Message({this.id, this.roomId, this.user, this.content, this.uploads, this.isProcessing, this.isNotification, this.createdAt});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      roomId: json['room_id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      content: json['content'],
      uploads: json['uploads'] != null ? (json['uploads'] as List).map((i) => Upload.fromJson(i)).toList() : null,
      isProcessing: json['is_processing'],
      isNotification: json['is_notification'],
      createdAt: json['created_at'],
    );
  }
}

class Upload {
  final int? id;
  final String? file;
  final String? fileUrl;
  final String? filename;
  final String? type;
  final int? size;
  final List<Aux>? aux;

  Upload({this.id, this.file, this.fileUrl, this.filename, this.type, this.size, this.aux});

  factory Upload.fromJson(Map<String, dynamic> json) {
    return Upload(
      id: json['id'],
      file: json['file'],
      fileUrl: json['file_url'],
      filename: json['filename'],
      type: json['type'],
      size: json['size'],
      aux: json['aux'] != null ? (json['aux'] as List).map((i) => Aux.fromJson(i)).toList() : null,
    );
  }
}

class Aux {
  final String? type;
  final Upload? upload;

  Aux({this.type, this.upload});

  factory Aux.fromJson(Map<String, dynamic> json) {
    return Aux(
      type: json['type'],
      upload: json['upload'] != null ? Upload.fromJson(json['upload']) : null,
    );
  }
}

class Pagination {
  final int? currentPage;
  final int? from;
  final int? lastPage;
  final int? perPage;
  final int? to;
  final int? total;

  Pagination({this.currentPage, this.from, this.lastPage, this.perPage, this.to, this.total});

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
}
