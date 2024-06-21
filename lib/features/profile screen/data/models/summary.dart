class Summary {
  int? love;
  int? wow;
  int? like;
  int? haha;
  int? angry;
  int? sad;

  Summary({this.love, this.wow, this.haha, this.like});

  Summary.fromJson(Map<String, dynamic> json)
      : love = json['love'],
        haha = json['haha'],
        like = json['like'],
        angry = json['angry'],
        sad = json['sad'],
        wow = json['wow'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['love'] = this.love;
    data['wow'] = this.wow;
    data['like'] = this.like;
    data['haha'] = this.haha;
    data['angry'] = this.angry;
    data['sad'] = this.sad;
    return data;
  }
}
