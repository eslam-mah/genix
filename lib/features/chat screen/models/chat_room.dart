// To parse this JSON data, do
//
//     final chatRoom = chatRoomFromJson(jsonString);

import 'dart:convert';

import 'package:genix/features/chat%20screen/models/data.dart';

ChatRoom chatRoomFromJson(String str) => ChatRoom.fromJson(json.decode(str));

String chatRoomToJson(ChatRoom data) => json.encode(data.toJson());

class ChatRoom {
  final int? id;
  final ChatRoomUser? user;
  final int? initiatorId;
  final dynamic name;
  final dynamic profileImg;
  final String? coverImg;
  final List<ChatRoomParticipant>? participants;
  final ChatRoomLastMessage? lastMessage;
  final int? isGroup;
  final bool? isStarred;
  final bool? isUnread;
  final DateTime? updatedAt;

  ChatRoom({
    this.id,
    this.user,
    this.initiatorId,
    this.name,
    this.profileImg,
    this.coverImg,
    this.participants,
    this.lastMessage,
    this.isGroup,
    this.isStarred,
    this.isUnread,
    this.updatedAt,
  });

  ChatRoom copyWith({
    int? id,
    ChatRoomUser? user,
    int? initiatorId,
    dynamic name,
    dynamic profileImg,
    String? coverImg,
    List<ChatRoomParticipant>? participants,
    ChatRoomLastMessage? lastMessage,
    int? isGroup,
    bool? isStarred,
    bool? isUnread,
    DateTime? updatedAt,
  }) =>
      ChatRoom(
        id: id ?? this.id,
        user: user ?? this.user,
        initiatorId: initiatorId ?? this.initiatorId,
        name: name ?? this.name,
        profileImg: profileImg ?? this.profileImg,
        coverImg: coverImg ?? this.coverImg,
        participants: participants ?? this.participants,
        lastMessage: lastMessage ?? this.lastMessage,
        isGroup: isGroup ?? this.isGroup,
        isStarred: isStarred ?? this.isStarred,
        isUnread: isUnread ?? this.isUnread,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ChatRoom.fromJson(Map<String, dynamic> json) => ChatRoom(
        id: json["id"],
        user: json["user"] == null ? null : ChatRoomUser.fromJson(json["user"]),
        initiatorId: json["initiator_id"],
        name: json["name"],
        profileImg: json["profile_img"],
        coverImg: json["cover_img"],
        participants: json["participants"] == null
            ? []
            : List<ChatRoomParticipant>.from(json["participants"]!
                .map((x) => ChatRoomParticipant.fromJson(x))),
        lastMessage: json["last_message"] == null
            ? null
            : ChatRoomLastMessage.fromJson(json["last_message"]),
        isGroup: json["is_group"],
        isStarred: json["is_starred"],
        isUnread: json["is_unread"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "initiator_id": initiatorId,
        "name": name,
        "profile_img": profileImg,
        "cover_img": coverImg,
        "participants": participants == null
            ? []
            : List<dynamic>.from(participants!.map((x) => x.toJson())),
        "last_message": lastMessage?.toJson(),
        "is_group": isGroup,
        "is_starred": isStarred,
        "is_unread": isUnread,
        "updated_at": updatedAt?.toIso8601String(),
      };

  static List<ChatRoom> dummyData =
      List<ChatRoom>.from(chatRoomDummyData.map((e) => ChatRoom.fromJson(e)));
}

class ChatRoomLastMessage {
  final int? id;
  final int? roomId;
  final ChatRoomUser? user;
  final String? content;
  final List<dynamic>? uploads;
  final List<ChatRoomReadReceipt>? readReceipts;
  final bool? isProcessing;
  final bool? isNotification;
  final DateTime? createdAt;

  ChatRoomLastMessage({
    this.id,
    this.roomId,
    this.user,
    this.content,
    this.uploads,
    this.readReceipts,
    this.isProcessing,
    this.isNotification,
    this.createdAt,
  });

  ChatRoomLastMessage copyWith({
    int? id,
    int? roomId,
    ChatRoomUser? user,
    String? content,
    List<dynamic>? uploads,
    List<ChatRoomReadReceipt>? readReceipts,
    bool? isProcessing,
    bool? isNotification,
    DateTime? createdAt,
  }) =>
      ChatRoomLastMessage(
        id: id ?? this.id,
        roomId: roomId ?? this.roomId,
        user: user ?? this.user,
        content: content ?? this.content,
        uploads: uploads ?? this.uploads,
        readReceipts: readReceipts ?? this.readReceipts,
        isProcessing: isProcessing ?? this.isProcessing,
        isNotification: isNotification ?? this.isNotification,
        createdAt: createdAt ?? this.createdAt,
      );

  factory ChatRoomLastMessage.fromJson(Map<String, dynamic> json) =>
      ChatRoomLastMessage(
        id: json["id"],
        roomId: json["room_id"],
        user: json["user"] == null ? null : ChatRoomUser.fromJson(json["user"]),
        content: json["content"],
        uploads: json["uploads"] == null
            ? []
            : List<dynamic>.from(json["uploads"]!.map((x) => x)),
        readReceipts: json["read_receipts"] == null
            ? []
            : List<ChatRoomReadReceipt>.from(json["read_receipts"]!
                .map((x) => ChatRoomReadReceipt.fromJson(x))),
        isProcessing: json["is_processing"],
        isNotification: json["is_notification"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "room_id": roomId,
        "user": user?.toJson(),
        "content": content,
        "uploads":
            uploads == null ? [] : List<dynamic>.from(uploads!.map((x) => x)),
        "read_receipts": readReceipts == null
            ? []
            : List<dynamic>.from(readReceipts!.map((x) => x.toJson())),
        "is_processing": isProcessing,
        "is_notification": isNotification,
        "created_at": createdAt?.toIso8601String(),
      };
}

class ChatRoomReadReceipt {
  final int? id;
  final String? showname;
  final String? username;
  final String? profileImg;

  ChatRoomReadReceipt({
    this.id,
    this.showname,
    this.username,
    this.profileImg,
  });

  ChatRoomReadReceipt copyWith({
    int? id,
    String? showname,
    String? username,
    String? profileImg,
  }) =>
      ChatRoomReadReceipt(
        id: id ?? this.id,
        showname: showname ?? this.showname,
        username: username ?? this.username,
        profileImg: profileImg ?? this.profileImg,
      );

  factory ChatRoomReadReceipt.fromJson(Map<String, dynamic> json) =>
      ChatRoomReadReceipt(
        id: json["id"],
        showname: json["showname"],
        username: json["username"],
        profileImg: json["profile_img"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "showname": showname,
        "username": username,
        "profile_img": profileImg,
      };
}

class ChatRoomUser {
  final int? id;
  final String? username;
  final String? showname;
  final String? profileImg;
  final String? coverImg;
  final bool? isVerified;
  final DateTime? createdAt;
  final bool? isActive;

  ChatRoomUser({
    this.id,
    this.username,
    this.showname,
    this.profileImg,
    this.coverImg,
    this.isVerified,
    this.createdAt,
    this.isActive,
  });

  ChatRoomUser copyWith({
    int? id,
    String? username,
    String? showname,
    String? profileImg,
    String? coverImg,
    bool? isVerified,
    DateTime? createdAt,
    bool? isActive,
  }) =>
      ChatRoomUser(
        id: id ?? this.id,
        username: username ?? this.username,
        showname: showname ?? this.showname,
        profileImg: profileImg ?? this.profileImg,
        coverImg: coverImg ?? this.coverImg,
        isVerified: isVerified ?? this.isVerified,
        createdAt: createdAt ?? this.createdAt,
        isActive: isActive ?? this.isActive,
      );

  factory ChatRoomUser.fromJson(Map<String, dynamic> json) => ChatRoomUser(
        id: json["id"],
        username: json["username"],
        showname: json["showname"],
        profileImg: json["profile_img"],
        coverImg: json["cover_img"],
        isVerified: json["is_verified"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        isActive: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "showname": showname,
        "profile_img": profileImg,
        "cover_img": coverImg,
        "is_verified": isVerified,
        "created_at": createdAt?.toIso8601String(),
        "is_active": isActive,
      };
}

class ChatRoomParticipant {
  final int? id;
  final ChatRoomUser? user;
  final int? roomId;
  final DateTime? updatedAt;

  ChatRoomParticipant({
    this.id,
    this.user,
    this.roomId,
    this.updatedAt,
  });

  ChatRoomParticipant copyWith({
    int? id,
    ChatRoomUser? user,
    int? roomId,
    DateTime? updatedAt,
  }) =>
      ChatRoomParticipant(
        id: id ?? this.id,
        user: user ?? this.user,
        roomId: roomId ?? this.roomId,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory ChatRoomParticipant.fromJson(Map<String, dynamic> json) =>
      ChatRoomParticipant(
        id: json["id"],
        user: json["user"] == null ? null : ChatRoomUser.fromJson(json["user"]),
        roomId: json["room_id"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user": user?.toJson(),
        "room_id": roomId,
        "updated_at": updatedAt?.toIso8601String(),
      };
}
