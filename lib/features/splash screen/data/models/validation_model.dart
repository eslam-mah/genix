class ValidationModel {
  final bool success;
  final DataModel data;
  final String? message;

  ValidationModel({
    required this.success,
    required this.data,
    this.message,
  });

  factory ValidationModel.fromJson(Map<String, dynamic> json) {
    return ValidationModel(
      success: json['success'] ?? false,
      data: DataModel.fromJson(json['data'] ?? {}),
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
      'message': message,
    };
  }
}

class DataModel {
  final SettingsModel? settings;
  final UserModel? user;
  final List<CustomEmoji>? customEmoji;

  DataModel({
    this.settings,
    this.user,
    this.customEmoji,
  });

  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      settings: json['settings'] != null
          ? SettingsModel.fromJson(json['settings'])
          : null,
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
      customEmoji: (json['custom_emoji'] as List?)
              ?.map((e) => CustomEmoji.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'settings': settings?.toJson(),
      'user': user?.toJson(),
      'custom_emoji': customEmoji?.map((e) => e.toJson()).toList(),
    };
  }
}

class SettingsModel {
  final String? realCurrency;
  final String? realCurrencyCode;
  final List<int>? stripeDefaultCoinsValues;
  final String? coinsCurrencyRate;
  final String? payoutFeeRate;
  final int? payoutMinLimit;
  final List<int>? promotionDefaultCoinsValues;
  final bool maintenanceEnabled;

  SettingsModel({
    this.realCurrency,
    this.realCurrencyCode,
    this.stripeDefaultCoinsValues,
    this.coinsCurrencyRate,
    this.payoutFeeRate,
    this.payoutMinLimit,
    this.promotionDefaultCoinsValues,
    required this.maintenanceEnabled,
  });

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      realCurrency: json['real_currency'] ?? '',
      realCurrencyCode: json['real_currency_code'] ?? '',
      stripeDefaultCoinsValues:
          List<int>.from(json['stripe_default_coins_values'] ?? []),
      coinsCurrencyRate: json['coins_currency_rate'] ?? '',
      payoutFeeRate: json['payout_fee_rate'] ?? '',
      payoutMinLimit: json['payout_min_limit'] ?? 0,
      promotionDefaultCoinsValues:
          List<int>.from(json['promotion_default_coins_values'] ?? []),
      maintenanceEnabled: json['maintenance_enabled'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'real_currency': realCurrency,
      'real_currency_code': realCurrencyCode,
      'stripe_default_coins_values': stripeDefaultCoinsValues,
      'coins_currency_rate': coinsCurrencyRate,
      'payout_fee_rate': payoutFeeRate,
      'payout_min_limit': payoutMinLimit,
      'promotion_default_coins_values': promotionDefaultCoinsValues,
      'maintenance_enabled': maintenanceEnabled,
    };
  }
}

class UserModel {
  final int? id;
  final String? username;
  final String? showname;
  final String? email;
  final int? coins;
  final int? revenueCoins;
  final int? revenue;
  final bool allowFollowers;
  final bool allowNotifications;
  final bool allowTags;
  final bool allowSearchEngines;
  final bool allowEmails;
  final bool hideGender;
  final bool hideAge;
  final bool hideLocation;
  final String? dateOfBirth;
  final String? paypalEmail;
  final String? profileImg;
  final String? coverImg;
  final String? gender;
  final String? bio;
  final String? country;
  final String? city;
  final int? age;
  final List<String>? roles;
  final List<String>? permissions;
  final bool verified;
  final bool tfaEnabled;
  final bool isVerified;
  final String? createdAt;
  final bool isActive;
  final int? status;
  final String? locale;

  UserModel({
    this.id,
    this.username,
    this.showname,
    this.email,
    this.coins,
    this.revenueCoins,
    this.revenue,
    required this.allowFollowers,
    required this.allowNotifications,
    required this.allowTags,
    required this.allowSearchEngines,
    required this.allowEmails,
    required this.hideGender,
    required this.hideAge,
    required this.hideLocation,
    this.dateOfBirth,
    this.paypalEmail,
    this.profileImg,
    this.coverImg,
    this.gender,
    this.bio,
    this.country,
    this.city,
    this.age,
    this.roles,
    this.permissions,
    required this.verified,
    required this.tfaEnabled,
    required this.isVerified,
    this.createdAt,
    required this.isActive,
    this.status,
    this.locale,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      username: json['username'] ?? '',
      showname: json['showname'] ?? '',
      email: json['email'] ?? '',
      coins: json['coins'] ?? 0,
      revenueCoins: json['revenue_coins'] ?? 0,
      revenue: json['revenue'] ?? 0,
      allowFollowers: json['allow_followers'] ?? false,
      allowNotifications: json['allow_notifications'] ?? false,
      allowTags: json['allow_tags'] ?? false,
      allowSearchEngines: json['allow_search_engines'] ?? false,
      allowEmails: json['allow_emails'] ?? false,
      hideGender: json['hide_gender'] ?? false,
      hideAge: json['hide_age'] ?? false,
      hideLocation: json['hide_location'] ?? false,
      dateOfBirth: json['date_of_birth'] ?? '',
      paypalEmail: json['paypal_email'],
      profileImg: json['profile_img'] ?? '',
      coverImg: json['cover_img'],
      gender: json['gender'] ?? '',
      bio: json['bio'] ?? '',
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      age: json['age'] ?? 0,
      roles: List<String>.from(json['roles'] ?? []),
      permissions: List<String>.from(json['permissions'] ?? []),
      verified: json['verified'] ?? false,
      tfaEnabled: json['tfa_enabled'] ?? false,
      isVerified: json['is_verified'] ?? false,
      createdAt: json['created_at'] ?? '',
      isActive: json['is_active'] ?? false,
      status: json['status'] ?? 0,
      locale: json['locale'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'showname': showname,
      'email': email,
      'coins': coins,
      'revenue_coins': revenueCoins,
      'revenue': revenue,
      'allow_followers': allowFollowers,
      'allow_notifications': allowNotifications,
      'allow_tags': allowTags,
      'allow_search_engines': allowSearchEngines,
      'allow_emails': allowEmails,
      'hide_gender': hideGender,
      'hide_age': hideAge,
      'hide_location': hideLocation,
      'date_of_birth': dateOfBirth,
      'paypal_email': paypalEmail,
      'profile_img': profileImg,
      'cover_img': coverImg,
      'gender': gender,
      'bio': bio,
      'country': country,
      'city': city,
      'age': age,
      'roles': roles,
      'permissions': permissions,
      'verified': verified,
      'tfa_enabled': tfaEnabled,
      'is_verified': isVerified,
      'created_at': createdAt,
      'is_active': isActive,
      'status': status,
      'locale': locale,
    };
  }
}

class CustomEmoji {
  final String? filename;
  final String? fileUrl;

  CustomEmoji({
    this.filename,
    this.fileUrl,
  });

  factory CustomEmoji.fromJson(Map<String, dynamic> json) {
    return CustomEmoji(
      filename: json['filename'] ?? '',
      fileUrl: json['file_url'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'filename': filename,
      'file_url': fileUrl,
    };
  }
}
