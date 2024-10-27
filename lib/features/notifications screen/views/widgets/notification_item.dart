import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/features/notifications%20screen/data/models/notifications_model.dart';
import 'package:intl/intl.dart';

class NotificationItem extends StatelessWidget {
  const NotificationItem({
    super.key,
    required this.notification,
    required this.isNightMode,
  });
  final NotificationsModel notification;
  final bool isNightMode;
  @override
  Widget build(BuildContext context) {
    String formatNotificationDate(String createdAt) {
      // Parse the string to DateTime
      DateTime dateTime = DateTime.parse(createdAt);

      // Format the DateTime object
      String formattedDate = DateFormat('MMMM d, yyyy').format(dateTime);

      return formattedDate;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        children: [
          _CustomUserProfileImage(
            image: notification.data.thumbnail,
            isActive: false,
            showname: notification.data.content,
          ),
          SizedBox(
            width: 10.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  maxLines: 5,
                  textSize: 15.sp,
                  fontFamily: '',
                  fontWeight: FontWeight.normal,
                  text: notification.data.content,
                ),
                CustomTextWidget(
                  textSize: 15.sp,
                  fontFamily: '',
                  fontWeight: FontWeight.normal,
                  color: Colors.grey.shade400,
                  text: formatNotificationDate(notification.createdAt),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _CustomUserProfileImage extends StatelessWidget {
  const _CustomUserProfileImage({
    super.key,
    required this.image,
    required this.isActive,
    required this.showname,
  });

  final String image;
  final bool isActive;
  final String showname;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 25.w, // Increased size of the CircleAvatar
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: image,
              width: 120.w, // Increased width
              height: 120.w, // Added height to maintain aspect ratio
              fit: BoxFit.cover,
              errorWidget: (context, error, stackTrace) {
                return Container(
                  color: Colors.purple,
                  alignment: Alignment.center,
                  child: Text(
                    showname.split('').take(2).join().toUpperCase(),
                    style: TextStyle(fontSize: 19.sp),
                  ),
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 3.h,
          right: 4.w,
          child: isActive
              ? CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 8,
                )
              : SizedBox.shrink(),
        ),
        Positioned(
          bottom: 4.h,
          right: 5.w,
          child: isActive
              ? CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 6, // Increased size of the green circle
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }
}
