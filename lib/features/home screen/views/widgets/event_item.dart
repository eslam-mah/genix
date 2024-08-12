import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/core/widgets/customuserprofileimage.dart';
import 'package:genix/features/home%20screen/data/models/posts_model/posts_model.dart';
import 'package:genix/features/home%20screen/views/widgets/event_widget.dart';
import 'package:genix/features/home%20screen/views/widgets/show_post_tabbar_dialoge.dart';
import 'package:genix/features/profile%20screen/views/view/profile_page.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:html/parser.dart' show parse; // Add this import

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
  bool reactionView = false;
  bool isVideo = false;
  bool isPoll = false;
  int reactNum = 0;
  String _removeHtmlTags(String htmlString) {
    final document = parse(htmlString);
    return document.body?.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.postsModel.user;
    final content = widget.postsModel.content != null
        ? _removeHtmlTags(widget.postsModel.content!)
        : '';
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
                      InkWell(
                        onTap: () {
                          GoRouter.of(context).push(ProfilePage.route,
                              extra: widget.postsModel);
                        },
                        borderRadius: BorderRadius.circular(400.r),
                        child: CustomUserProfileImage(
                          image: user.profileImg ?? '',
                          isActive: user.isActive ?? false,
                        ),
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
                                  .format(widget.postsModel.createdAt!))
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
                            Align(
                              alignment: Alignment.centerLeft,
                              child: CustomTextWidget(
                                  textSize: 15.sp,
                                  fontFamily: '',
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                  text: content),
                            ),
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
