class Summary {
  int? like;
  int? love;
  int? wow;
  int? haha;
  int? angry;
  int? sad;

  Summary({this.like, this.love, this.wow, this.haha, this.angry, this.sad});

  Summary.fromJson(Map<String, dynamic> json)
      : like = json['like'],
        love = json['love'],
        wow = json['wow'],
        haha = json['haha'],
        angry = json['angry'],
        sad = json['sad'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['like'] = like;
    data['love'] = love;
    data['wow'] = wow;
    data['haha'] = haha;
    data['angry'] = angry;
    data['sad'] = sad;
    return data;
  }
}
