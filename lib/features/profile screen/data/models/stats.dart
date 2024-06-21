class Stats {
  int? postsCount;
  int? postsCommentsCount;

  Stats({this.postsCount, this.postsCommentsCount});

  Stats.fromJson(Map<String, dynamic> json)
      : postsCount = json['posts_count'],
        postsCommentsCount = json['posts_comments_count'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['posts_count'] = this.postsCount;
    data['posts_comments_count'] = this.postsCommentsCount;
    return data;
  }
}
