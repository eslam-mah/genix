import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/utils/router.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/core/widgets/customuserprofileimage.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_list.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/views/widgets/custom_post_components.dart';
import 'package:genix/features/home%20screen/views/widgets/event_widget.dart';
import 'package:genix/features/home%20screen/views/widgets/share_bottom_sheet.dart';
import 'package:genix/features/home%20screen/views/widgets/show_post_tabbar_dialoge.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

enum Reaction { cry, cute, angry, laugh, love, sad, surprise, wink, none }

class EventItem extends StatefulWidget {
  const EventItem({
    super.key,
    required this.isNightModeEnabled,
    required this.postsModel,
  });
  final bool isNightModeEnabled;
  final PostsModel postsModel;

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  Reaction reaction = Reaction.none;
  bool reactionView = false;
  bool isVideo = false;
  bool isPoll = false;
  int reactNum = 0;

  @override
  Widget build(BuildContext context) {
    final user = widget.postsModel.user;

    if (user == null) {
      return Container();
    }

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: AppColors.kPostColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 7.h),
              child: Column(
                children: [
                  Row(
                    children: [
                      CustomUserProfileImage(
                        image: user.profileImg ?? '',
                        isActive: user.isActive ?? false,
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(user.showname ?? 'Unknown User'),
                                if (widget.postsModel.user!.isVerified != null)
                                  Image.asset(
                                    AppGifs.kVerified,
                                    width: 20.w,
                                  )
                              ],
                            ),
                            if (user.createdAt != null)
                              Text(DateFormat('MMMM d, yyyy')
                                  .format(user.createdAt!))
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showPostTabBar(context, widget.isNightModeEnabled);
                        },
                        icon: const Icon(FontAwesomeIcons.ellipsis),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  widget.postsModel.content != null
                      ? Column(
                          children: [
                            CustomTextWidget(
                                textSize: 15.sp,
                                fontFamily: '',
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                                text: widget.postsModel.content ?? ''),
                            SizedBox(height: 7.h),
                          ],
                        )
                      : const SizedBox.shrink(),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(6.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        EventWidget(
                          icon: FontAwesomeIcons.calendar,
                          text: 'Location',
                          eventText: widget.postsModel.misc?.checkin ?? '',
                        ),
                        EventWidget(
                          icon: FontAwesomeIcons.clock,
                          text: 'Timestamp',
                          eventText: widget.postsModel.misc?.timestamp ?? '',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
