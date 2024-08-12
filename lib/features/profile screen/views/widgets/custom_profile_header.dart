import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/customeditingprofilewidget.dart';
import 'package:genix/features/profile%20screen/views/widgets/custom_icon_counter.dart';
import 'package:genix/features/profile%20screen/views/widgets/edit_background_pic.dart';
import 'package:genix/features/profile%20screen/views/widgets/edit_profile_pic.dart';

class CustomProfileHeader extends StatelessWidget {
  const CustomProfileHeader({
    super.key,
    required this.imageUrl,
    required this.profileName,
    required this.followersCount,
    required this.friendsCount,
    required this.likesCount,
    required this.savedCount,
    required this.bioText,
    required this.coverImageUrl,
  });
  final String imageUrl;
  final String profileName;
  final String bioText;
  final String coverImageUrl;
  final num followersCount;
  final num friendsCount;
  final num likesCount;
  final num savedCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 400.h,
          color: Colors.white,
          child: CachedNetworkImage(
            errorWidget: (context, error, stackTrace) {
              return Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  child: const SizedBox());
            },
            imageUrl: coverImageUrl,
          ),
        ),
        Positioned(
          top: 40.h,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 300.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomUserProfileEditingImage(
                  size: 37.r,
                  smallSize: 10.r,
                  fontSize: 30.sp,
                  positionBottom: 1.h,
                  positionRight: 7.w,
                  whiteSize: 0,
                  icon: FontAwesomeIcons.pen,
                  onTapIcon: () {
                    editProfilePicBottomSheet(context);
                  },
                  imageUrl: imageUrl,
                ),
                Text(
                  profileName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 108, 184, 246),
                  radius: 15.r,
                  child: Icon(
                    FontAwesomeIcons.pen,
                    size: 15.r,
                    color: Colors.white,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5.r)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Text(
                      bioText,
                      style: TextStyle(fontSize: 15.sp, color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    editBackgroundPicBottomSheet(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.grey,
                    radius: 10.r,
                    child: Icon(
                      FontAwesomeIcons.pen,
                      size: 10.r,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Positioned(
            top: 360.h,
            left: 33.w,
            child: Container(
              // width: 300.w,
              decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor2,
                  borderRadius: BorderRadius.circular(8.r)),
              child: Row(
                children: [
                  CustomCounterIcon(
                    icon: FontAwesomeIcons.users,
                    number: followersCount.toInt(),
                  ),
                  CustomCounterIcon(
                    icon: FontAwesomeIcons.userPlus,
                    number: friendsCount.toInt(),
                  ),
                  CustomCounterIcon(
                    icon: FontAwesomeIcons.solidHeart,
                    number: likesCount.toInt(),
                  ),
                  CustomCounterIcon(
                    icon: FontAwesomeIcons.clipboardUser,
                    number: savedCount.toInt(),
                  ),
                ],
              ),
            ))
      ],
    );
  }
}
