import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/customeditingprofilewidget.dart';
import 'package:genix/features/my%20profile%20screen/widgets/custom_icon_counter.dart';
import 'package:genix/features/my%20profile%20screen/widgets/edit_background_pic.dart';
import 'package:genix/features/my%20profile%20screen/widgets/edit_profile_pic.dart';

class CustomProfileHeader extends StatelessWidget {
  const CustomProfileHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 360.h,
          color: Colors.white,
          //child: Image.asset(AppImages.kPost)
        ),
        Positioned(
          top: 40.h,
          left: 150.w,
          child: CustomUserProfileEditingImage(
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
          ),
        ),
        Positioned(
            top: 120.h,
            left: 166.w,
            child: Text(
              'User',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  shadows: const [
                    Shadow(
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    )
                  ]),
            )),
        Positioned(
            top: 170.h,
            left: 173.w,
            child: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 108, 184, 246),
              radius: 15.r,
              child: Icon(
                FontAwesomeIcons.pen,
                size: 15.r,
                color: Colors.white,
              ),
            )),
        Positioned(
            top: 230.h,
            left: 90.w,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.grey, borderRadius: BorderRadius.circular(5.r)),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 5.w),
                child: Text(
                  'Hey there, Iam using Genix!',
                  style: TextStyle(fontSize: 15.sp, color: Colors.white),
                ),
              ),
            )),
        Positioned(
            top: 285.h,
            left: 310.w,
            child: GestureDetector(
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
            )),
        Positioned(
            top: 317.h,
            left: 33.w,
            child: Container(
              // width: 300.w,
              decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor2,
                  borderRadius: BorderRadius.circular(8.r)),
              child: const Row(
                children: [
                  CustomCounterIcon(
                    icon: FontAwesomeIcons.users,
                    number: 1,
                  ),
                  CustomCounterIcon(
                    icon: FontAwesomeIcons.userPlus,
                    number: 1,
                  ),
                  CustomCounterIcon(
                    icon: FontAwesomeIcons.solidHeart,
                    number: 1,
                  ),
                  CustomCounterIcon(
                    icon: FontAwesomeIcons.clipboardUser,
                    number: 1,
                  ),
                ],
              ),
            ))
      ],
    );
  }
}
