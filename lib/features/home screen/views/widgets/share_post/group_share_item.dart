import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/groups%20page/data/models/groups_model.dart';

class GroupShareItem extends StatelessWidget {
  const GroupShareItem({
    super.key,
    required this.isSelected,
    required this.onTap,
    required this.group,
  });

  final bool isSelected;
  final GroupsModel group;
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
                  imageUrl: group.profileImg,
                  width: 30.w,
                  height: 30.w,
                  fit: BoxFit.fill,
                  errorWidget: (context, error, stackTrace) {
                    return Image.asset(
                      AppImages.kLogo,
                    );
                  },
                ),
              ),
            ),
            Text(
              group.name,
              style: TextStyle(fontSize: 15.sp),
            )
          ],
        ),
      ),
    );
  }
}
