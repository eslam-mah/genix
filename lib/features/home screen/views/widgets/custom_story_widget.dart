import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/features/home%20screen/data/models/stories_list.dart';

import 'package:genix/features/home%20screen/data/models/stories_list_model.dart';
import 'package:genix/features/story%20screen/view%20model/see_story/see_story_cubit.dart';
import 'package:genix/features/story%20screen/views/view/story_screen.dart';
import 'package:go_router/go_router.dart';

class CustomStoryWidget extends StatefulWidget {
  const CustomStoryWidget({
    super.key,
    required this.storyModel,
    required this.storyList,
    required this.storyListIndex,
    required this.storyIndex,
  });

  final StoriesListModel storyModel;
  final StoryList storyList;
  final int storyListIndex;
  final int storyIndex;

  @override
  State<CustomStoryWidget> createState() => _CustomStoryWidgetState();
}

class _CustomStoryWidgetState extends State<CustomStoryWidget> {
  late ValueNotifier<bool> isViewed;
  @override
  void initState() {
    super.initState();
    isViewed =
        ValueNotifier(widget.storyModel.collection?.last.viewed ?? false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeeStoryCubit, SeeStoryState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 5.h),
          child: IconButton(
            onPressed: () async {
              await context
                  .read<SeeStoryCubit>()
                  .seeStory(id: widget.storyModel.collection?.last.id ?? 0);
              GoRouter.of(context).push(
                StoryScreen.routeName,
                extra: {
                  'storyList': widget.storyList,
                  'startingStoryIndex': widget.storyListIndex,
                },
              );
            },
            icon: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    ValueListenableBuilder<bool>(
                        valueListenable: isViewed,
                        builder: (context, isViewed, _) {
                          return CircleAvatar(
                            backgroundColor: isViewed
                                ? Colors.grey
                                : const Color.fromARGB(255, 14, 215, 21),
                            radius: 30.r,
                          );
                        }),
                    Positioned(
                      left: 3.w,
                      bottom: 3.h,
                      child: CircleAvatar(
                        radius: 27.r,
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: widget.storyModel.profileImg ?? '',
                            width: 60.w,
                            fit: BoxFit.cover,
                            errorWidget: (context, error, stackTrace) {
                              return Container(
                                color: Colors.purple,
                                alignment: Alignment.center,
                                child: Text(
                                  widget.storyModel.showname
                                          ?.split('')
                                          .take(2)
                                          .join()
                                          .toUpperCase() ??
                                      '',
                                  style: TextStyle(fontSize: 17.sp),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                SizedBox(
                  width: 70.w,
                  child: Center(
                    child: Text(
                      widget.storyModel.showname ?? '',
                      style: TextStyle(fontSize: 13.sp),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
