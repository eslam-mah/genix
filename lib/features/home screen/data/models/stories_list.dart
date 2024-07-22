import 'package:genix/features/home%20screen/data/models/stories_list_model.dart';

///
/// List of Stories model
/// includes data that comes from no filter get Stories request
///
class StoryList {
  bool success;
  Data data;

  StoryList({required this.success, required this.data});

  StoryList.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        data = Data.fromJson(json['data'] ?? []);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['data'] = this.data.toJson();
    return data;
  }
}

///
/// Data class is to handle the array of Stories that comes from the non-filter
/// GET request separated from the other meta data
///
class Data {
  List<StoriesListModel> stories;

  Data({required this.stories});

  Data.fromJson(List stories)
      : this.stories = stories
            .where((s) => s != null)
            .where((s) {
              try {
                StoriesListModel.fromJson(s);
                return true;
              } catch (e) {
                print("Error processing story: $e");
                return false;
              }
            })
            .map((s) => StoriesListModel.fromJson(s))
            .toList();

  List<Map<String, dynamic>> toJson() {
    final List<Map<String, dynamic>> data =
        this.stories.map((storyModel) => storyModel.toJson()).toList();
    return data;
  }

  // void addStory({required StoriesListModel story}) {
  //   this.stories.add(story);
  // }

  // void updateStory({required StoriesListModel newStory}) {
  //   final updatedStoryIndex =
  //       this.stories.indexWhere((s) => s.id == newStory.id);
  //   if (updatedStoryIndex != -1) {
  //     this.stories[updatedStoryIndex] = newStory;
  //   }
  // }

  // void deleteStory(int storyId) {
  //   final removedStoryIndex = this.stories.indexWhere((s) => s.id == storyId);
  //   if (removedStoryIndex != -1) {
  //     this.stories.removeAt(removedStoryIndex);
  //   }
  // }
}
