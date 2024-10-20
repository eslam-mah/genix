class Summary {
  int? love;
  int? wow;
  int? haha;
  int? angry;
  int? sad;
  int? like;

  Summary({this.love, this.wow, this.haha, this.angry, this.sad, this.like});

  Summary.fromJson(Map<String, dynamic> json)
      : love = json['love'],
        wow = json['wow'],
        haha = json['haha'],
        angry = json['angry'],
        sad = json['sad'],
        like = json['like'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['love'] = love;
    data['wow'] = wow;
    data['haha'] = haha;
    data['angry'] = angry;
    data['sad'] = sad;
    data['like'] = like;
    return data;
  }
}
