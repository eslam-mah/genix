import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';

Future<dynamic> donationBottomSheet(BuildContext context) {
  return showModalBottomSheet(
      //isScrollControlled: true,
      showDragHandle: true,
      backgroundColor: AppColors.kPostColor,
      enableDrag: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(builder: (context, setState) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Column(
                  children: [
                    Expanded(
                        child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              'Donations',
                              style: TextStyle(
                                  fontSize: 19.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 20.w,
                            ),
                            Text(
                              'Help the short creator.',
                              style: TextStyle(
                                  fontSize: 13.sp, color: Colors.grey),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Container(
                          color: Colors.grey,
                          height: 1.h,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Expanded(
                          child: GridView.builder(
                            itemCount: 9,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Image.asset(AppImages.kLaughReact),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          FontAwesomeIcons.coins,
                                          color: const Color.fromARGB(
                                              255, 196, 176, 1),
                                        ),
                                        SizedBox(
                                          width: 10.w,
                                        ),
                                        Text('10000')
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0,
                              childAspectRatio: 0.7,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        Container(
                          color: Colors.grey,
                          height: 1.h,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: SizedBox(
                                          height: 150.h,
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {},
                                                  child: ListTile(
                                                    title: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 50.w,
                                                        ),
                                                        Icon(FontAwesomeIcons
                                                            .coins),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        Text('Donate')
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () {},
                                                  child: ListTile(
                                                    title: Row(
                                                      children: [
                                                        SizedBox(
                                                          width: 50.w,
                                                        ),
                                                        Icon(FontAwesomeIcons
                                                            .users),
                                                        SizedBox(
                                                          width: 10.w,
                                                        ),
                                                        Text('Top donations')
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Container(
                                alignment: Alignment.bottomLeft,
                                height: 22.h,
                                decoration: BoxDecoration(
                                    color: AppColors.kPostColor,
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.2))),
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.w),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.arrowsUpDown,
                                        color: Colors.black,
                                        size: 15.sp,
                                      ),
                                      SizedBox(
                                        width: 5.w,
                                      ),
                                      Text(
                                        'Donate',
                                        style: TextStyle(fontSize: 13.sp),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.bottomLeft,
                              height: 22.h,
                              decoration: BoxDecoration(
                                  color: AppColors.kPostColor,
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.2))),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.coins,
                                      color: const Color.fromARGB(
                                          255, 196, 176, 1),
                                      size: 15.sp,
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    Text(
                                      '02',
                                      style: TextStyle(fontSize: 13.sp),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ))
                  ],
                ),
              ),
            ),
          );
        });
      });
}
