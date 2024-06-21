class Rating {
  int? average;
  dynamic myRating;

  Rating({this.average, this.myRating});

  Rating.fromJson(Map<String, dynamic> json)
      : average = json['average'],
        myRating = json['my_rating'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['average'] = this.average;
    data['my_rating'] = this.myRating;
    return data;
  }
}
