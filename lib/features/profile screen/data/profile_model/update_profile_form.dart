// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

class UpdateProfileForm {
  String method;
  File? profileImg;
  File? coverImg;

  UpdateProfileForm({
    required this.method,
    this.profileImg,
    this.coverImg,
  });

  UpdateProfileForm.fromJson(Map<String, dynamic> json)
      : method = json['_method'] as String,
        profileImg = json['profile_img'] as File?,
        coverImg = json['cover_img'] as File?;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_method'] = method;
    data['profile_img'] = profileImg;
    data['cover_img'] = coverImg;
    return data;
  }
}
//   UpdateProfileForm copyWith({
//     String? method,
//     String? profileImg,
//     String? coverImg,
//   }) {
//     return UpdateProfileForm(
//       method: method ?? this.method,
//       profileImg: profileImg ?? this.profileImg,
//       coverImg: coverImg ?? this.coverImg,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'method': method,
//       'profileImg': profileImg,
//       'coverImg': coverImg,
//     };
//   }

//   factory UpdateProfileForm.fromMap(Map<String, dynamic> map) {
//     return UpdateProfileForm(
//       method: map['method'] as String,
//       profileImg: map['profileImg'] != null ? map['profileImg'] as String : null,
//       coverImg: map['coverImg'] != null ? map['coverImg'] as String : null,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory UpdateProfileForm.fromJson(String source) => UpdateProfileForm.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'UpdateProfileForm(method: $method, profileImg: $profileImg, coverImg: $coverImg)';

//   @override
//   bool operator ==(covariant UpdateProfileForm other) {
//     if (identical(this, other)) return true;

//     return
//       other.method == method &&
//       other.profileImg == profileImg &&
//       other.coverImg == coverImg;
//   }

//   @override
//   int get hashCode => method.hashCode ^ profileImg.hashCode ^ coverImg.hashCode;
// }
