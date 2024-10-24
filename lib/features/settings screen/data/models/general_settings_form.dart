class GeneralSettingsForm {
  bool? allowFollowers;
  bool? allowNotifications;
  bool? allowTags;
  bool? allowSearchEngines;
  bool? hideGender;
  bool? hideAge;
  bool? hideLocation;
  String? locale;

  GeneralSettingsForm({
    this.allowFollowers,
    this.allowNotifications,
    this.allowTags,
    this.allowSearchEngines,
    this.hideGender,
    this.hideAge,
    this.hideLocation,
    this.locale,
  });

  GeneralSettingsForm.fromJson(Map<String, dynamic> json)
      : allowFollowers = json['allow_followers'],
        allowNotifications = json['allow_notifications'],
        allowTags = json['allow_tags'],
        allowSearchEngines = json['allow_search_engines'],
        hideGender = json['hide_gender'],
        hideAge = json['hide_age'],
        hideLocation = json['hide_location'],
        locale = json['locale'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['allow_followers'] = this.allowFollowers;
    data['allow_notifications'] = this.allowNotifications;
    data['allow_tags'] = this.allowTags;
    data['allow_search_engines'] = this.allowSearchEngines;
    data['hide_gender'] = this.hideGender;
    data['hide_age'] = this.hideAge;
    data['hide_location'] = this.hideLocation;
    data['locale'] = this.locale;
    return data;
  }
}
