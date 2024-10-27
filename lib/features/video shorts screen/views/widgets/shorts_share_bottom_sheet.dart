import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/widgets/custombutton.dart';

Future<dynamic> shortsShareBottomSheet(BuildContext context) {
  int typeSelected = 0;
  bool isSelected = false;
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
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                child: SizedBox(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Share this post to',
                        style: TextStyle(fontSize: 15.sp),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                typeSelected = typeSelected == 1 ? 0 : 1;
                              });
                            },
                            child: Container(
                              width: 157.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: typeSelected == 1
                                        ? Colors.green
                                        : Colors.black.withOpacity(0.5),
                                  ),
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(FontAwesomeIcons.userGroup,
                                      color: Colors.green),
                                  Text(
                                    'Followings',
                                    style: TextStyle(fontSize: 15.sp),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                typeSelected = typeSelected == 2 ? 0 : 2;
                              });
                            },
                            child: Container(
                              width: 157.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: typeSelected == 2
                                        ? Colors.green
                                        : Colors.black.withOpacity(0.5),
                                  ),
                                  borderRadius: BorderRadius.circular(12.r)),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Icon(FontAwesomeIcons.solidClipboard,
                                      color: Colors.green),
                                  Text(
                                    'Copy link',
                                    style: TextStyle(fontSize: 15.sp),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Visibility(
                        visible: typeSelected == 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'SELECT AN USER',
                              style: TextStyle(
                                fontSize: 10.sp,
                              ),
                            ),
                            SizedBox(
                              height: 6.h,
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  isSelected = !isSelected;
                                });
                              },
                              child: Container(
                                width: 157.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: isSelected
                                          ? Colors.green
                                          : Colors.black.withOpacity(0.5),
                                    ),
                                    borderRadius: BorderRadius.circular(12.r)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CircleAvatar(
                                      radius: 10,
                                      child: Image.asset(AppImages.kLogo),
                                    ),
                                    Text(
                                      'User111',
                                      style: TextStyle(fontSize: 15.sp),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomButton(
                          color: AppColors.kPrimaryColor,
                          buttonText: 'Share now',
                          width: double.infinity,
                          height: 40.h,
                          borderRadius: 12.r,
                          onTap: () {})
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      });
}
