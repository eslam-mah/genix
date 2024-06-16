class UserForm {
  final Map<String, dynamic> roles;
  final Map<String, dynamic>? permissions;
  final String username;
  final String showname;
  final String email;
  final String? password;
  final String? country;
  final String? city;
  final String? gender;
  final String dateOfBirth;
  final String? bio;
  final String? paypalEmail;
  final String? socialFacebook;
  final String? socialTiktok;
  final String? socialInstagram;
  final String? socialTwitter;
  final String? socialPinterest;
  final String? socialSteam;
  final String? socialLinkedin;

  UserForm({
    required this.roles,
    this.permissions,
    required this.username,
    required this.showname,
    required this.email,
    this.password,
    this.country,
    this.city,
    this.gender,
    required this.dateOfBirth,
    this.bio,
    this.paypalEmail,
    this.socialFacebook,
    this.socialTiktok,
    this.socialInstagram,
    this.socialTwitter,
    this.socialPinterest,
    this.socialSteam,
    this.socialLinkedin,
  });

  factory UserForm.fromJson(Map<String, dynamic> json) {
    return UserForm(
      roles: json['roles'],
      permissions: json['permissions'],
      username: json['username'],
      showname: json['showname'],
      email: json['email'],
      password: json['password'],
      country: json['country'],
      city: json['city'],
      gender: json['gender'],
      dateOfBirth: json['date_of_birth'],
      bio: json['bio'],
      paypalEmail: json['paypal_email'],
      socialFacebook: json['social_facebook'],
      socialTiktok: json['social_tiktok'],
      socialInstagram: json['social_instagram'],
      socialTwitter: json['social_twitter'],
      socialPinterest: json['social_pinterest'],
      socialSteam: json['social_steam'],
      socialLinkedin: json['social_linkedin'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['roles'] = this.roles;
    data['permissions'] = this.permissions;
    data['username'] = this.username;
    data['showname'] = this.showname;
    data['email'] = this.email;
    data['password'] = this.password;
    data['country'] = this.country;
    data['city'] = this.city;
    data['gender'] = this.gender;
    data['date_of_birth'] = this.dateOfBirth;
    data['bio'] = this.bio;
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
