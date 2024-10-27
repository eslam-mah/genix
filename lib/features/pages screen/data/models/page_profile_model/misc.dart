class Misc {
  String? checkin;
  String? timestamp;

  Misc({this.checkin, this.timestamp});

  factory Misc.fromJson(Map<String, dynamic> json) => Misc(
        checkin: json['checkin'] as String?,
        timestamp: json['timestamp'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'checkin': checkin,
        'timestamp': timestamp,
      };
}
