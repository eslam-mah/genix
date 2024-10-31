// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:genix/features/home%20screen/data/models/stories_list_model.dart';
// import 'package:genix/features/home%20screen/views/widgets/custom_story_widget.dart';

// class StoryList extends StatelessWidget {
//   const StoryList({
//     super.key,
//     required this.storyModel,
//   });
//   final StoriesListModel storyModel;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 98.h,
//       child: ListView.builder(
//         itemBuilder: (context, index) {
//           return CustomStoryWidget(
//             storyModel: storyModel, storyList: Story,
//           );
//         },
//         itemCount: 10,
//         physics: const BouncingScrollPhysics(),
//         scrollDirection: Axis.horizontal,
//       ),
//     );
//   }
// }
