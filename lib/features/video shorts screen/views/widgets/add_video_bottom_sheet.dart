import 'dart:io'; // Import dart:io for File handling
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customtextfield2.dart';
import 'package:genix/features/video%20shorts%20screen/view%20model/cubit/add_short_cubit.dart';
import 'package:go_router/go_router.dart';

Future<dynamic> addVideoBottomSheet(BuildContext context) {
  // Variable to store the picked file
  File? videoFile;

  return showModalBottomSheet(
    isScrollControlled: true,
    showDragHandle: true,
    enableDrag: true,
    context: context,
    builder: (context) {
      return BlocProvider(
        create: (context) => AddShortCubit(),
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            TextEditingController contentController = TextEditingController();
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      videoFile == null
                          ? Column(
                              children: [
                                Icon(
                                  FontAwesomeIcons.video,
                                  color: Colors.green,
                                  size: 50.r,
                                ),
                                SizedBox(height: 20.h),
                                Text(
                                  'First of all, select a video',
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 20.h),
                                CustomButton(
                                  color: AppColors.kPrimaryColor2,
                                  buttonText: 'Browse on device',
                                  width: 160.w,
                                  height: 40.h,
                                  borderRadius: 7.r,
                                  onTap: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                      type: FileType.video,
                                    );

                                    if (result != null &&
                                        result.files.single.path != null) {
                                      setState(() {
                                        videoFile =
                                            File(result.files.single.path!);
                                      });
                                    }
                                  },
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                // Displaying video preview or selected file path
                                Icon(
                                  FontAwesomeIcons.fileVideo,
                                  color: AppColors.kPrimaryColor,
                                  size: 50.r,
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  'Video selected!',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Text(
                                  videoFile!.path,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13.w),
                        child: CustomTextField2(
                          readOnly: false,
                          hintText: 'short description, #tags',
                          controller: contentController,
                          icon: const SizedBox.shrink(),
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13.w),
                        child: CustomButton(
                          color: AppColors.kPrimaryColor,
                          buttonText: '↑ Post short',
                          width: double.infinity,
                          height: 37.h,
                          borderRadius: 10.r,
                          onTap: () {
                            // Ensure that videoFile is not null before calling the cubit
                            if (videoFile != null) {
                              context.read<AddShortCubit>().addShort(
                                  video: videoFile ?? File(''),
                                  content: contentController.text.trim());
                              GoRouter.of(context).pop();
                            } else {
                              GoRouter.of(context).pop();

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Please select a video file.")),
                              );
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    },
  );
}
