import 'package:genix/features/settings%20screen/data/models/settings_model.dart';

class SettingsList {
  bool success;
  Data data;

  SettingsList({required this.success, required this.data});

  factory SettingsList.fromJson(Map<String, dynamic> json) {
    return SettingsList(
      success: json['success'],
      data: Data.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    data['data'] = this.data.toJson();
    return data;
  }
}

class Data {
  List<SettingsModel> settings;

  Data({required this.settings});

  factory Data.fromJson(Map<String, dynamic> json) {
    var settingsJson = json['data'] as List;
    List<SettingsModel> settingsList =
        settingsJson.map((i) => SettingsModel.fromJson(i)).toList();

    return Data(
      settings: settingsList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] =
        this.settings.map((SettingsModel) => SettingsModel.toJson()).toList();
    return data;
  }
}
