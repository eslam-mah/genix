class ShareForm {
  String type;
  String? content;
  String? userId;
  String? groupId;
  String? pageId;

  ShareForm({
    required this.type,
    this.content,
    this.userId,
    this.groupId,
    this.pageId,
  });

  ShareForm.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        content = json['content'],
        userId = json['user_id'],
        groupId = json['group_id'],
        pageId = json['page_id'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['content'] = content;
    data['user_id'] = userId;
    data['group_id'] = groupId;
    data['page_id'] = pageId;
    return data;
  }
}
