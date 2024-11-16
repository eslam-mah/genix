import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';

import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/custompromotewidget.dart';
import 'package:genix/core/widgets/custompromotewidget2.dart';

import '../../../../core/localization/all_app_strings.dart';

Future<dynamic> promoteBottomSheet(BuildContext context) {
  int isSelected = 0;
  return showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        '${AppStrings.promote.getString(context)}',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Text(
                        '${AppStrings.increaseyourpopularity.getString(context)}',
                        style: TextStyle(fontSize: 10.sp),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 1.h,
                    color: Colors.black.withOpacity(0.1),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isSelected = isSelected == 1 ? 0 : 1;
                          });
                        },
                        child: CustomPromoteWidget(
                          isSelected: isSelected,
                          numberSelected: 1,
                          coins: 100,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isSelected = isSelected == 2 ? 0 : 2;
                          });
                        },
                        child: CustomPromoteWidget(
                          isSelected: isSelected,
                          numberSelected: 2,
                          coins: 500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isSelected = isSelected == 3 ? 0 : 3;
                          });
                        },
                        child: CustomPromoteWidget(
                          isSelected: isSelected,
                          numberSelected: 3,
                          coins: 1000,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isSelected = isSelected == 4 ? 0 : 4;
                          });
                        },
                        child: CustomPromoteWidget(
                          isSelected: isSelected,
                          numberSelected: 4,
                          coins: 5000,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isSelected = isSelected == 5 ? 0 : 5;
                          });
                        },
                        child: CustomPromoteWidget(
                          isSelected: isSelected,
                          numberSelected: 5,
                          coins: 10000,
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isSelected = isSelected == 6 ? 0 : 6;
                          });
                        },
                        child: CustomPromoteWidget2(
                          isSelected: isSelected,
                          numberSelected: 6,
                          coins: 0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomButton(
                      color: AppColors.kPrimaryColor,
                      buttonText: '${AppStrings.allocatecoinsforpromotions.getString(context)}',
                      width: double.infinity,
                      height: 40.h,
                      borderRadius: 12.r,
                      onTap: () {}),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    height: 22.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                        color: AppColors.kPostColor,
                        border:
                            Border.all(color: Colors.black.withOpacity(0.2))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          FontAwesomeIcons.coins,
                          color: const Color.fromARGB(255, 196, 176, 1),
                          size: 15.sp,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          '0',
                          style: TextStyle(fontSize: 13.sp),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                ],
              ),
            ),
          ));
        });
      });
}
