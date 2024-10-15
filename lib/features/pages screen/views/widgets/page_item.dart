import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/pages%20screen/data/models/pages_model.dart';
import 'package:go_router/go_router.dart';

class PageItem extends StatelessWidget {
  final PagesModel page;
  const PageItem({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    final themeState = context.read<ThemeCubit>().state;

    return InkWell(
      onTap: () {},
      child: Container(
        height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
            border: Border.all(
                color: themeState == ThemeState.dark
                    ? Colors.white
                    : Colors.black.withOpacity(0.2))),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(400.r),
              child: Container(
                width: 45.w,
                height: 45.w,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: CachedNetworkImage(
                  imageUrl: page.profileImg,
                  width: 45.w,
                  height: 45.w,
                  fit: BoxFit.cover,
                  errorWidget: (context, error, stackTrace) {
                    return Image.asset(
                      AppImages.kLogo,
                      width: 50.w,
                      height: 45.w,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              width: 10.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                    textSize: 17.sp,
                    fontFamily: '',
                    fontWeight: FontWeight.normal,
                    text: page.name),
                Row(
                  children: [
                    Icon(Icons.verified,
                        color: AppColors.kPrimaryColor, size: 15.sp),
                    CustomTextWidget(
                        textSize: 15.sp,
                        fontFamily: '',
                        fontWeight: FontWeight.normal,
                        color: AppColors.kPrimaryColor,
                        text: ' Page followed'),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
