class ReportForm {
  String content;
  String? postId;
  String? groupId;
  String? pageId;
  String? profileId;

  ReportForm({
    required this.content,
    this.postId,
    this.groupId,
    this.pageId,
    this.profileId,
  }) {
    if (content.length < 5) {
      throw ArgumentError("Content must be at least 5 characters long.");
    }
  }

  ReportForm.fromJson(Map<String, dynamic> json)
      : content = json['content'],
        postId = json['post_id'],
        groupId = json['group_id'],
        pageId = json['page_id'],
        profileId = json['profile_id'] {
    if (content.length < 5) {
      throw ArgumentError("Content must be at least 5 characters long.");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['post_id'] = this.postId;
    data['group_id'] = this.groupId;
    data['page_id'] = this.pageId;
    data['profile_id'] = this.profileId;
    return data;
  }
}
