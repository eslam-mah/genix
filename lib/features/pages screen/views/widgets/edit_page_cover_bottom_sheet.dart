import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/features/pages%20screen/view%20model/update_page_profile/update_page_profile_cubit.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/localization/all_app_strings.dart';

Future<dynamic> editPageCoverBottomSheet(
    BuildContext context, Function()? refresh, final int id) {
  return showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        FilePickerResult? result;
        File? pickedFile;

        return BlocProvider(
          create: (context) => UpdatePageProfileCubit(),
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            UpdatePageProfileCubit updatePageProfileCubit =
                BlocProvider.of<UpdatePageProfileCubit>(context);

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
                  updatePageProfileCubit.updatePageProfile(
                      id: id, coverImg: pickedFile);

                  // ignore: use_build_context_synchronously
                  GoRouter.of(context).pop();
                  refresh!();
                  refresh();
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
                      Text('${AppStrings.firstofallselectanimage.getString(context)}',
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      CustomButton(
                          color: AppColors.kPrimaryColor2,
                          buttonText: '${AppStrings.browseondevice.getString(context)}',
                          width: 160.w,
                          height: 40.h,
                          borderRadius: 7.r,
                          onTap: () {
                            pickFile();
                          }),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      });
}
