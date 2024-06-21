import 'package:genix/features/settings%20screen/data/models/settings_model.dart';

class SettingsList {
  String status;
  Data data;

  SettingsList({required this.status, required this.data});

  factory SettingsList.fromJson(Map<String, dynamic> json) {
    return SettingsList(
      status: json['status'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = this.status;
    data['data'] = this.data.toJson();
    return data;
  }
}

class Data {
  List<SettingsModel> settings;

  Data({required this.settings});

  factory Data.fromJson(Map<String, dynamic> json) {
    var settingsJson = json['collection'] as List;
    List<SettingsModel> settingsList =
        settingsJson.map((i) => SettingsModel.fromJson(i)).toList();

    return Data(
      settings: settingsList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['collection'] =
        this.settings.map((SettingsModel) => SettingsModel.toJson()).toList();
    return data;
  }

  void addSetting({required SettingsModel user}) {
    this.settings.add(user);
  }

  void updateSetting({required SettingsModel newUser}) {
    final updatedUserIndex =
        this.settings.indexWhere((u) => u.id == newUser.id);
    if (updatedUserIndex != -1) {
      this.settings[updatedUserIndex] = newUser;
    }
  }

  void deleteSetting(int userId) {
    final removedUserIndex = this.settings.indexWhere((u) => u.id == userId);
    if (removedUserIndex != -1) {
      this.settings.removeAt(removedUserIndex);
    }
  }
}
