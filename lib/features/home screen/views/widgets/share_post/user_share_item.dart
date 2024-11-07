import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/followings%20list%20page/data/models/followings_model.dart';

class FollowingsShareItem extends StatelessWidget {
  const FollowingsShareItem({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.user,
  });

  final bool isSelected;
  final FollowingsModel user;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: Container(
        width: 157.w,
        height: 40.h,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.5),
                blurRadius: isSelected ? 6 : 0,
              )
            ],
            border: Border.all(
              color: isSelected ? Colors.green : Colors.black.withOpacity(0.5),
            ),
            color: ThemeCubit().state == ThemeState.dark
                ? DarkModeColors.kItemColorDark
                : AppColors.kTextFieldColor,
            borderRadius: BorderRadius.circular(12.r)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(200.r),
              child: Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: CachedNetworkImage(
                  imageUrl: user.user.profileImg,
                  width: 30.w,
                  height: 30.w,
                  fit: BoxFit.fill,
                  errorWidget: (context, error, stackTrace) {
                    return Container(
                        width: 0.w,
                        decoration: const BoxDecoration(
                            color: Colors.purple, shape: BoxShape.circle),
                        alignment: Alignment.center,
                        child: Center(
                          child: Text(
                              user.user.showname
                                  .split('')
                                  .take(2)
                                  .join()
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontSize: 12.sp, color: Colors.white)),
                        ));
                  },
                ),
              ),
            ),
            Text(
              user.user.showname,
              style: TextStyle(fontSize: 15.sp),
            )
          ],
        ),
      ),
    );
  }
}
