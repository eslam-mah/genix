class Reactions {
  List<dynamic>? summary;
  dynamic byMe;

  Reactions({this.summary, this.byMe});

  factory Reactions.fromJson(Map<String, dynamic> json) => Reactions(
        summary: json['summary'] as List<dynamic>?,
        byMe: json['by_me'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'summary': summary,
        'by_me': byMe,
      };
}
