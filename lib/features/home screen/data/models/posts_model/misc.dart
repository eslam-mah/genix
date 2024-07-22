class PollOption {
  String? title;
  List<int>? votesFromUsers;

  PollOption({
    this.title,
    this.votesFromUsers,
  });

  PollOption.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String?,
        votesFromUsers = (json['votes_from_users'] as List<dynamic>?)
            ?.map((e) => e as int)
            .toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = title;
    if (votesFromUsers != null) {
      data['votes_from_users'] = votesFromUsers;
    }
    return data;
  }
}

class Poll {
  String? question;
  List<PollOption>? options;

  Poll({
    this.question,
    this.options,
  });

  Poll.fromJson(Map<String, dynamic> json)
      : question = json['question'] as String?,
        options = (json['options'] as List<dynamic>?)
            ?.map((e) => PollOption.fromJson(e as Map<String, dynamic>))
            .toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = question;
    if (options != null) {
      data['options'] = options!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Misc {
  Poll? poll;
  String? checkin;
  String? timestamp;

  Misc({
    this.poll,
    this.checkin,
    this.timestamp,
  });

  Misc.fromJson(Map<String, dynamic> json)
      : poll = json['poll'] != null
            ? Poll.fromJson(json['poll'] as Map<String, dynamic>)
            : null,
        checkin = json['checkin'] as String?,
        timestamp = json['timestamp'] as String?;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (poll != null) {
      data['poll'] = poll!.toJson();
    }
    data['checkin'] = checkin;
    data['timestamp'] = timestamp;
    return data;
  }
}
