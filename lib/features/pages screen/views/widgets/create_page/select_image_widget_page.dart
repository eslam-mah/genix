import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/customtextwidget.dart';

import '../../../../../core/localization/all_app_strings.dart';

class SelectImagePage extends StatelessWidget {
  final Function() onSelectProfile;
  final Function() onSelectCover;
  final ValueNotifier<String?> profilePathNotifier;
  final ValueNotifier<String?> coverPathNotifier;

  const SelectImagePage({
    super.key,
    required this.onSelectProfile,
    required this.profilePathNotifier,
    required this.onSelectCover,
    required this.coverPathNotifier,
  });

  @override
  Widget build(BuildContext context) {
    final Widget spacerSmall = SizedBox(
      height: 10.h,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            CustomTextWidget(
              textSize: 16.sp,
              fontFamily: '',
              fontWeight: FontWeight.bold,
              text: '${AppStrings.groupprofilepicture.getString(context)}',
            ),
            CustomTextWidget(
              textSize: 12.sp,
              fontFamily: '',
              color: Colors.red,
              fontWeight: FontWeight.bold,
              text: '${AppStrings.required.getString(context)}',
            ),
            spacerSmall,
            InkWell(
              onTap: onSelectProfile,
              child: Container(
                width: 140.w,
                height: 160.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.kPrimaryColor)),
                child: ValueListenableBuilder<String?>(
                  valueListenable: profilePathNotifier, // Listen to changes
                  builder: (context, filePath, _) {
                    return filePath != null && filePath.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.file(
                              File(
                                  filePath), // Use the file path to display the image
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                FontAwesomeIcons.fileImage,
                                size: 60.sp,
                                color: AppColors.kPrimaryColor,
                              ),
                              CustomTextWidget(
                                  textSize: 16.sp,
                                  fontFamily: '',
                                  fontWeight: FontWeight.bold,
                                  text: '${AppStrings.selectaimage.getString(context)}'),
                            ],
                          );
                  },
                ),
              ),
            ),
          ],
        ),
        Column(
          children: [
            CustomTextWidget(
              textSize: 16.sp,
              fontFamily: '',
              fontWeight: FontWeight.bold,
              text: '${AppStrings.groupcoverpicture.getString(context)}',
            ),
            CustomTextWidget(
              textSize: 12.sp,
              fontFamily: '',
              color: Colors.red,
              fontWeight: FontWeight.bold,
              text: '${AppStrings.required.getString(context)}',
            ),
            spacerSmall,
            InkWell(
              onTap: onSelectCover,
              child: Container(
                width: 140.w,
                height: 160.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: AppColors.kPrimaryColor)),
                child: ValueListenableBuilder<String?>(
                  valueListenable: coverPathNotifier, // Listen to changes
                  builder: (context, filePath, _) {
                    return filePath != null && filePath.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8.r),
                            child: Image.file(
                              File(
                                  filePath), // Use the file path to display the image
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                FontAwesomeIcons.images,
                                size: 60.sp,
                                color: AppColors.kPrimaryColor,
                              ),
                              CustomTextWidget(
                                  textSize: 16.sp,
                                  fontFamily: '',
                                  fontWeight: FontWeight.bold,
                                  text: '${AppStrings.selectaimage.getString(context)}'),
                            ],
                          );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
