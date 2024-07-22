class StoryModel {
  int? id;
  String? type;
  int? duration;
  String? url;
  int? time;
  dynamic myReaction;
  bool? viewed;
  int? views;

  StoryModel({
    this.id,
    this.type,
    this.duration,
    this.url,
    this.time,
    this.myReaction,
    this.viewed,
    this.views,
  });

  StoryModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        type = json['type'] as String?,
        duration = json['duration'] as int?,
        url = json['url'] as String?,
        time = json['time'] as int?,
        myReaction = json['my_reaction'],
        viewed = json['viewed'] as bool?,
        views = json['views'] as int?;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['duration'] = duration;
    data['url'] = url;
    data['time'] = time;
    data['my_reaction'] = myReaction;
    data['viewed'] = viewed;
    data['views'] = views;
    return data;
  }
}
