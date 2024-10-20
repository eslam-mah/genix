import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';

import 'package:genix/core/widgets/custombutton.dart';

Future<dynamic> reportBottomSheet(
  BuildContext context,
) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'SUBMIT A NEW REPORT',
                      style: TextStyle(fontSize: 11.sp),
                    ),
                    const Text(
                      'Report post',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text('Content', style: TextStyle(fontSize: 11.sp)),
                    Text(
                        'Feed this report with a comprehensive content. please include as many details as you can, in all the possible forms to get a proper resolution.',
                        style: TextStyle(fontSize: 11.sp)),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.kTextFieldColor,
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      height: 120.h,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          TextField(
                            expands: true,
                            maxLines: null,
                            decoration: InputDecoration(
                              hintText: ' Write something...',
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.2)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                  borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.2))),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                  borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.2))),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(12, 12, 48, 12),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                  borderSide: BorderSide(
                                      color: Colors.black.withOpacity(0.2))),
                            ),
                            textAlignVertical: TextAlignVertical.top,
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: IconButton(
                              icon: const Icon(FontAwesomeIcons.solidFaceSmile),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    CustomButton(
                        color: AppColors.kPrimaryColor,
                        buttonText: 'Report now',
                        width: double.infinity,
                        height: 40.h,
                        borderRadius: 12.r,
                        onTap: () {}),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                )),
          ));
        });
      });
}
