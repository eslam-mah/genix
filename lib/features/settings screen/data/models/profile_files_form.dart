class ProfileFilesForm {
  String? profileImg;
  String? coverImg;

  ProfileFilesForm({this.profileImg, this.coverImg});

  ProfileFilesForm.fromJson(Map<String, dynamic> json)
      : profileImg = json['profile_img'],
        coverImg = json['cover_img'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['profile_img'] = this.profileImg;
    data['cover_img'] = this.coverImg;
    return data;
  }
}
