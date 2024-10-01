class Summary {
  int? love;
  int? cute;
  int? wow;
  int? haha;
  int? angry;
  int? sad;
  int? wink;
  int? cry;

  Summary({this.love, this.cute, this.wow, this.haha, this.angry, this.sad});

  Summary.fromJson(Map<String, dynamic> json)
      : love = json['like'],
        cute = json['love'],
        wow = json['wow'],
        haha = json['haha'],
        angry = json['angry'],
        sad = json['sad'],
        cry = json['cry'],
        wink = json['wink'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['like'] = love;
    data['love'] = cute;
    data['wow'] = wow;
    data['haha'] = haha;
    data['angry'] = angry;
    data['sad'] = sad;
    data['wink'] = wink;
    data['cry'] = cry;
    return data;
  }
}
