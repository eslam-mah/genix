class Stats {
  int? postsCount;
  int? postsCommentsCount;

  Stats({this.postsCount, this.postsCommentsCount});

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        postsCount: json['posts_count'] as int?,
        postsCommentsCount: json['posts_comments_count'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'posts_count': postsCount,
        'posts_comments_count': postsCommentsCount,
      };
}
