import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/features/settings%20screen/view%20model/update%20my%20profile/update_my_profile_cubit.dart';
import 'package:go_router/go_router.dart';

Future<dynamic> editBackgroundPicBottomSheet(
    BuildContext context, Function()? refresh) {
  return showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        FilePickerResult? result;
        File? pickedFile;
        return BlocProvider(
          create: (context) => UpdateMyProfileCubit(),
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            UpdateMyProfileCubit updateMyProfileCubit =
                BlocProvider.of<UpdateMyProfileCubit>(context);

            Future<void> pickFile() async {
              try {
                result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                  allowMultiple: false,
                );
                if (result != null && result?.files.single.path != null) {
                  setState(() {
                    pickedFile =
                        File(result!.files.single.path!); // Extract file
                  });
                  updateMyProfileCubit.updateProfile(coverImg: pickedFile);
                  // ignore: use_build_context_synchronously
                  GoRouter.of(context).pop();
                  refresh!();
                }
              } catch (e) {
                print(e);
              }
            }

            return Padding(
              padding: EdgeInsets.only(bottom: 40.h),
              child: SingleChildScrollView(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.image,
                        color: Colors.green,
                        size: 50.r,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(
                        'First of all, select an image',
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomButton(
                          color: AppColors.kPrimaryColor2,
                          buttonText: 'Browse on device',
                          width: 160.w,
                          height: 40.h,
                          borderRadius: 7.r,
                          onTap: () {
                            pickFile();
                          })
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      });
}
