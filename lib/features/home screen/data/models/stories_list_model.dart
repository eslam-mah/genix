import 'package:genix/features/story%20screen/data/models/story_model.dart';

class StoriesListModel {
  int? id;
  String? profileImg;
  String? showname;
  List<StoryModel>? collection;

  StoriesListModel({
    this.id,
    this.profileImg,
    this.showname,
    this.collection,
  });

  StoriesListModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        profileImg = json['profile_img'] as String?,
        showname = json['showname'] as String?,
        collection = json['collection'] != null
            ? (json['collection'] as List<dynamic>)
                .map((v) => StoryModel.fromJson(v as Map<String, dynamic>))
                .toList()
            : null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['profile_img'] = profileImg;
    data['showname'] = showname;
    if (collection != null) {
      data['collection'] = collection!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
