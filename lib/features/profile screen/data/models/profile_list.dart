import 'profile_model.dart';

class ProfileList {
  String status;
  Data data;

  ProfileList({required this.status, required this.data});

  factory ProfileList.fromJson(Map<String, dynamic> json) {
    return ProfileList(
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
  List<ProfileModel> profiles;

  Data({required this.profiles});

  factory Data.fromJson(Map<String, dynamic> json) {
    var profilesJson = json['profiles'] as List;
    List<ProfileModel> profilesList =
        profilesJson.map((i) => ProfileModel.fromJson(i)).toList();

    return Data(
      profiles: profilesList,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['profiles'] =
        this.profiles.map((profileModel) => profileModel.toJson()).toList();
    return data;
  }

  void addProfile({required ProfileModel profile}) {
    this.profiles.add(profile);
  }

  void updateProfile({required ProfileModel newProfile}) {
    final updatedProfileIndex =
        this.profiles.indexWhere((p) => p.user.id == newProfile.user.id);
    if (updatedProfileIndex != -1) {
      this.profiles[updatedProfileIndex] = newProfile;
    }
  }

  void deleteProfile(int userId) {
    final removedProfileIndex =
        this.profiles.indexWhere((p) => p.user.id == userId);
    if (removedProfileIndex != -1) {
      this.profiles.removeAt(removedProfileIndex);
    }
  }
}
