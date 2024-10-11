import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/customeditingprofilewidget.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
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
    required this.isProfileEditorShown,
    this.refresh,
  });
  final String imageUrl;
  final String profileName;
  final String bioText;
  final String coverImageUrl;
  final num followersCount;
  final num friendsCount;
  final num likesCount;
  final num savedCount;
  final bool isProfileEditorShown;
  final Function()? refresh;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 400.h,
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            errorWidget: (context, error, stackTrace) {
              return Container(
                  alignment: Alignment.center, child: const SizedBox());
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
                    editProfilePicBottomSheet(context, refresh);
                  },
                  imageUrl: imageUrl,
                  isProfileEditorShown: isProfileEditorShown,
                ),
                Text(
                  profileName,
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        color: ThemeCubit().state == ThemeState.dark
                            ? Colors.black
                            : Colors.white,
                        blurRadius: 10.r,
                      ),
                      Shadow(
                        color: ThemeCubit().state == ThemeState.dark
                            ? Colors.black
                            : Colors.white,
                        blurRadius: 10.r,
                      ),
                      Shadow(
                        color: ThemeCubit().state == ThemeState.dark
                            ? Colors.black
                            : Colors.white,
                        blurRadius: 10.r,
                      )
                    ],
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                isProfileEditorShown
                    ? SizedBox.shrink()
                    // IconButton(
                    //     onPressed: () {
                    //       // todo: edit bio
                    //     },
                    //     icon: CircleAvatar(
                    //       backgroundColor:
                    //           const Color.fromARGB(255, 108, 184, 246),
                    //       radius: 15.r,
                    //       child: Icon(
                    //         FontAwesomeIcons.pen,
                    //         size: 15.r,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              // todo: remove friend
                            },
                            icon: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 15.r,
                              child: Icon(
                                FontAwesomeIcons.userMinus,
                                size: 15.r,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // todo: menu dialog
                            },
                            icon: CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 15.r,
                              child: Icon(
                                FontAwesomeIcons.ellipsis,
                                size: 15.r,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
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
                isProfileEditorShown
                    ? IconButton(
                        onPressed: () {
                          editBackgroundPicBottomSheet(context, refresh);
                        },
                        icon: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 15.r,
                          child: Icon(
                            FontAwesomeIcons.pen,
                            size: 15.r,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : const SizedBox()
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
