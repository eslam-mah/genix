import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/images.dart';

import 'package:genix/features/home%20screen/data/models/stories_list_model.dart';

class CustomStoryWidget extends StatelessWidget {
  const CustomStoryWidget({
    super.key,
    required this.storyModel,
  });
  final StoriesListModel storyModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: GestureDetector(
        onTap: () {
          //  Navigator.of(context).push(CustomTransition(MessageScreenBody()));
        },
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 14, 215, 21),
                  radius: 30.r,
                ),
                Positioned(
                    left: 3.w,
                    bottom: 3.h,
                    child: CircleAvatar(
                      radius: 27.r,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: storyModel.profileImg ?? '',
                          width: 60.w,
                          fit: BoxFit.cover,
                          errorWidget: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey,
                              alignment: Alignment.center,
                              child: Image.asset(
                                AppImages.kLogo,
                              ),
                            );
                          },
                        ),
                      ),
                    ))
              ],
            ),
            Text(storyModel.showname ?? '')
          ],
        ),
      ),
    );
  }
}
