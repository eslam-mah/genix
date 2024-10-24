import 'dart:io';

class ProfileForm {
  String? showname;
  String? username;
  String? email;
  String? bio;
  String? city;
  String? country;
  String? gender;
  File? profileImg;
  String? currentPassword;
  String? newPassword;
  String? paypalEmail;
  String? socialFacebook;
  String? socialTiktok;
  String? socialInstagram;
  String? socialTwitter;
  String? socialPinterest;
  String? socialSteam;
  String? socialLinkedin;

  ProfileForm({
    required this.showname,
    required this.username,
    required this.email,
    required this.bio,
    required this.city,
    required this.country,
    required this.gender,
    this.currentPassword,
    this.newPassword,
    this.paypalEmail,
    this.socialFacebook,
    this.socialTiktok,
    this.socialInstagram,
    this.socialTwitter,
    this.socialPinterest,
    this.socialSteam,
    this.socialLinkedin,
  });

  ProfileForm.fromJson(Map<String, dynamic> json)
      : showname = json['showname'],
        username = json['username'],
        email = json['email'],
        bio = json['bio'],
        city = json['city'],
        country = json['country'],
        gender = json['gender'],
        currentPassword = json['current_password'],
        newPassword = json['new_password'],
        paypalEmail = json['paypal_email'],
        socialFacebook = json['social_facebook'],
        socialTiktok = json['social_tiktok'],
        socialInstagram = json['social_instagram'],
        socialTwitter = json['social_twitter'],
        socialPinterest = json['social_pinterest'],
        socialSteam = json['social_steam'],
        socialLinkedin = json['social_linkedin'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['showname'] = this.showname;
    data['username'] = this.username;
    data['email'] = this.email;
    data['bio'] = this.bio;
    data['city'] = this.city;
    data['country'] = this.country;
    data['gender'] = this.gender;
    data['current_password'] = this.currentPassword;
    data['new_password'] = this.newPassword;
    data['paypal_email'] = this.paypalEmail;
    data['social_facebook'] = this.socialFacebook;
    data['social_tiktok'] = this.socialTiktok;
    data['social_instagram'] = this.socialInstagram;
    data['social_twitter'] = this.socialTwitter;
    data['social_pinterest'] = this.socialPinterest;
    data['social_steam'] = this.socialSteam;
    data['social_linkedin'] = this.socialLinkedin;
    return data;
  }
}
