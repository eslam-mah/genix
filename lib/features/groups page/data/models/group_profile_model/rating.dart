class Rating {
  int? average;
  dynamic myRating;

  Rating({this.average, this.myRating});

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        average: json['average'] as int?,
        myRating: json['my_rating'] as dynamic,
      );

  Map<String, dynamic> toJson() => {
        'average': average,
        'my_rating': myRating,
      };
}