import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/widgets/bigtextfield.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customtextfield2.dart';

Future<dynamic> addPostModalBottomSheet(BuildContext context) {
  bool isPoll = false;
  bool isCheckIn = false;
  bool isLive = false;
  int isPost = 1;
  bool isCloseFriend = false;
  List<Widget> textFields = [];

  return showModalBottomSheet(
      backgroundColor: AppColors.kAppBar2Color,
      isScrollControlled: true,
      showDragHandle: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          void addTextField() {
            textFields.add(
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Container(
                  decoration: BoxDecoration(
                      color: AppColors.kAppBar2Color,
                      borderRadius: BorderRadius.circular(13.r)),
                  child: CustomTextField2(
                    readOnly: false,
                    hintText: 'Type in the poll question',
                    controller: TextEditingController(),
                    isNightModeEnabled: false,
                    icon: const SizedBox.shrink(),
                  ),
                ),
              ),
            );
            setState(() {});
          }

          void removeTextField() {
            if (textFields.isNotEmpty) {
              textFields.removeLast();
              setState(() {});
            }
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Create post', style: TextStyle(fontSize: 20.sp)),
                  SizedBox(
                    height: 15.h,
                  ),
                  Visibility(
                    visible: isPost == 3 || isPost == 1,
                    child: const BigTextField(
                      hintText: ' Write something...',
                      color: AppColors.kTextFieldColor,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SizedBox(
                    height: 50.h,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: CircleAvatar(
                            backgroundColor: AppColors.kTextFieldColor,
                            radius: 20.r,
                            child: const Icon(
                              FontAwesomeIcons.image,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              isPost = isPost == 3 ? 0 : 3;
                            });
                          },
                          icon: CircleAvatar(
                            backgroundColor: AppColors.kTextFieldColor,
                            radius: 20.r,
                            child: const Icon(
                              FontAwesomeIcons.ellipsis,
                              color: Colors.black,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Visibility(
                        visible: isPost == 1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isPoll = !isPoll;
                              });
                            },
                            child: Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    isPoll
                                        ? BoxShadow(
                                            color: AppColors.kPrimaryColor2
                                                .withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: const Offset(0, 3),
                                          )
                                        : const BoxShadow(
                                            blurRadius: 0, spreadRadius: 0)
                                  ],
                                  color: isPoll
                                      ? AppColors.kPrimaryColor2
                                      : AppColors.kTextFieldColor,
                                  borderRadius: BorderRadius.circular(6.r)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    child: SizedBox(
                                        height: 17.h,
                                        child: Image.asset(
                                          AppImages.kPoll,
                                        )),
                                  ),
                                  Text(
                                    'Create a poll',
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: isPoll
                                            ? Colors.white
                                            : Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isPoll,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.kAppBar2Color,
                                  borderRadius: BorderRadius.circular(13.r)),
                              child: CustomTextField2(
                                  readOnly: false,
                                  hintText: 'Type in the poll question',
                                  controller: TextEditingController(),
                                  isNightModeEnabled: false,
                                  icon: const SizedBox.shrink()),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Column(
                              children: textFields,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.kAppBar2Color,
                                  borderRadius: BorderRadius.circular(13.r)),
                              child: CustomTextField2(
                                  readOnly: false,
                                  hintText: 'Type in the poll question',
                                  controller: TextEditingController(),
                                  isNightModeEnabled: false,
                                  icon: const SizedBox.shrink()),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8.h),
                              child: Container(
                                width: 40.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                    color: AppColors.kPrimaryColor,
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        removeTextField();
                                      });
                                    },
                                    icon: const Icon(
                                      FontAwesomeIcons.x,
                                      color: Colors.white,
                                    )),
                              ),
                            ),
                            CustomButton(
                                color: AppColors.kPrimaryColor2,
                                buttonText: '+ Add option',
                                width: double.infinity,
                                height: 36.h,
                                borderRadius: 6.r,
                                onTap: () {
                                  setState(() {
                                    addTextField();
                                  });
                                })
                          ],
                        ),
                      ),
                      Visibility(
                        visible: isPost == 1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isCheckIn = !isCheckIn;
                              });
                            },
                            child: Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    isCheckIn
                                        ? BoxShadow(
                                            color: AppColors.kPrimaryColor2
                                                .withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: const Offset(0, 3),
                                          )
                                        : const BoxShadow(
                                            blurRadius: 0, spreadRadius: 0)
                                  ],
                                  color: isCheckIn
                                      ? AppColors.kPrimaryColor2
                                      : AppColors.kTextFieldColor,
                                  borderRadius: BorderRadius.circular(6.r)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    child: SizedBox(
                                        height: 17.h,
                                        child: Image.asset(
                                          AppImages.kLocation,
                                        )),
                                  ),
                                  Text(
                                    'Check in',
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: isCheckIn
                                            ? Colors.white
                                            : Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isCheckIn,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                width: 100.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                    color: AppColors.kTextFieldColor,
                                    borderRadius: BorderRadius.circular(8.r)),
                                child: const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(FontAwesomeIcons.locationCrosshairs),
                                    Text(
                                      'Current',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.kAppBar2Color,
                                    borderRadius: BorderRadius.circular(13.r)),
                                child: CustomTextField2(
                                    readOnly: true,
                                    hintText: 'Custom location',
                                    controller: TextEditingController(),
                                    isNightModeEnabled: false,
                                    icon: const SizedBox.shrink()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: isPost == 1,
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                isLive = !isLive;
                              });
                            },
                            child: Container(
                              height: 40.h,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    isLive
                                        ? BoxShadow(
                                            color: AppColors.kPrimaryColor2
                                                .withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 7,
                                            offset: const Offset(0, 3),
                                          )
                                        : const BoxShadow(
                                            blurRadius: 0, spreadRadius: 0)
                                  ],
                                  color: isLive
                                      ? AppColors.kPrimaryColor2
                                      : AppColors.kTextFieldColor,
                                  borderRadius: BorderRadius.circular(6.r)),
                              child: Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.w),
                                    child: SizedBox(
                                        height: 17.h,
                                        child: Image.asset(
                                          AppImages.kLive,
                                        )),
                                  ),
                                  Text(
                                    'Go live',
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        color: isLive
                                            ? Colors.white
                                            : Colors.black),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isPost == 1,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  isCloseFriend = !isCloseFriend;
                                });
                              },
                              icon: Icon(
                                Icons.check_circle,
                                color: isCloseFriend
                                    ? AppColors.kPrimaryColor2
                                    : Colors.black.withOpacity(0.5),
                              ),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Icon(
                              FontAwesomeIcons.userGroup,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            SizedBox(
                              width: 30.w,
                            ),
                            Text(
                              'Only for close friends?',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.5)),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isPost = isPost == 1 ? 0 : 1;
                                });
                              },
                              icon: SizedBox(
                                  height: 16.h,
                                  child: CircleAvatar(
                                    backgroundColor: isPost == 1
                                        ? AppColors.kPrimaryColor2
                                        : Colors.black.withOpacity(0.2),
                                  ))),
                          SizedBox(
                            width: 20.w,
                          ),
                          Icon(
                            FontAwesomeIcons.solidSquarePlus,
                            color: Colors.black.withOpacity(0.5),
                            size: 35.sp,
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Text(
                            'News feed',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.5)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  isPost = isPost == 2 ? 0 : 2;
                                });
                              },
                              icon: SizedBox(
                                  height: 16.h,
                                  child: CircleAvatar(
                                    backgroundColor: isPost == 2
                                        ? AppColors.kPrimaryColor2
                                        : Colors.black.withOpacity(0.2),
                                  ))),
                          SizedBox(
                            width: 20.w,
                          ),
                          SizedBox(
                            height: 35.h,
                            child: CircleAvatar(
                              backgroundColor: Colors.purple,
                              child: Text(
                                'RA',
                                style: TextStyle(
                                    fontSize: 18.sp, color: Colors.white),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          Text(
                            'Story',
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.5)),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomButton(
                          color: AppColors.kPrimaryColor,
                          buttonText: 'Create post',
                          width: double.infinity,
                          height: 37.h,
                          borderRadius: 8.r,
                          onTap: () {})
                    ],
                  )
                ],
              ),
            ),
          );
        });
      });
}
