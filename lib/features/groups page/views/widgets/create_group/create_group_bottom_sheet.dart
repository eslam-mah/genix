import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/bigtextfield.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customtextfield2.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/create_group_cubit/create_group_cubit.dart';
import 'package:genix/features/groups%20page/views/widgets/create_group/group_category_menu.dart';
import 'package:genix/features/groups%20page/views/widgets/create_group/select_image_widget.dart';
import 'package:genix/features/groups%20page/views/widgets/create_group/social_link_widget.dart';
import 'package:go_router/go_router.dart';

Future<dynamic> createGroupBottomSheet(
  BuildContext context,
  Function() refresh,
) {
  return showModalBottomSheet(
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      enableDrag: true,
      context: context,
      builder: (context) {
        bool isLoading = false;

        return BlocProvider(
          create: (context) => CreateGroupCubit(),
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            ValueNotifier<String?> selectedProfilePathNotifier =
                ValueNotifier<String?>(null);
            ValueNotifier<String?> selectedCoverPathNotifier =
                ValueNotifier<String?>(null);
            TextEditingController groupNameController = TextEditingController();
            TextEditingController groupCategoryController =
                TextEditingController();
            TextEditingController groupWebsiteController =
                TextEditingController();
            TextEditingController groupAboutController =
                TextEditingController();
            TextEditingController facebookController = TextEditingController();
            TextEditingController xController = TextEditingController();
            TextEditingController instagramController = TextEditingController();
            TextEditingController tiktokController = TextEditingController();
            TextEditingController pinterestController = TextEditingController();
            TextEditingController steamController = TextEditingController();
            TextEditingController linkedInController = TextEditingController();

            // Function to pick a single file
            Future<void> pickProfile() async {
              try {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                  allowMultiple: false, // Only allow selecting one file
                );
                if (result != null && result.files.single.path != null) {
                  selectedProfilePathNotifier.value =
                      result.files.single.path; // Update the file path
                }
              } catch (e) {
                print("Error picking file: $e");
              }
            }

            Future<void> pickCover() async {
              try {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                  allowMultiple: false, // Only allow selecting one file
                );
                if (result != null && result.files.single.path != null) {
                  selectedCoverPathNotifier.value =
                      result.files.single.path; // Update the file path
                }
              } catch (e) {
                print("Error picking file: $e");
              }
            }

            final Widget spacer = SizedBox(
              height: 14.h,
            );
            final Widget spacerSmall = SizedBox(
              height: 10.h,
            );

            return Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomTextWidget(
                                textSize: 18.sp,
                                fontFamily: '',
                                fontWeight: FontWeight.bold,
                                text: 'Group name',
                              ),
                              CustomTextWidget(
                                textSize: 12.sp,
                                fontFamily: '',
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                text: '  required',
                              ),
                            ],
                          ),
                          spacerSmall,
                          CustomTextField2(
                              readOnly: false,
                              hintText: 'Group name',
                              controller: groupNameController,
                              icon: const Text('')),
                          spacer,
                          Row(
                            children: [
                              CustomTextWidget(
                                textSize: 18.sp,
                                fontFamily: '',
                                fontWeight: FontWeight.bold,
                                text: 'Category',
                              ),
                              CustomTextWidget(
                                textSize: 12.sp,
                                fontFamily: '',
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                text: '  required',
                              ),
                            ],
                          ),
                          spacerSmall,
                          CustomDropdownMenu(
                            categoryController: groupCategoryController,
                          ),
                          spacer,
                          SelectImage(
                              onSelectProfile: pickProfile,
                              onSelectCover: pickCover,
                              profilePathNotifier: selectedProfilePathNotifier,
                              coverPathNotifier:
                                  selectedCoverPathNotifier), // Call the pickFile function to pick an image
                          spacer,
                          Row(
                            children: [
                              CustomTextWidget(
                                textSize: 18.sp,
                                fontFamily: '',
                                fontWeight: FontWeight.bold,
                                text: 'Website',
                              ),
                              CustomTextWidget(
                                textSize: 12.sp,
                                fontFamily: '',
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                text: '  required',
                              ),
                            ],
                          ),
                          spacerSmall,
                          CustomTextField2(
                              readOnly: false,
                              hintText: 'Valid Website Url',
                              controller: groupWebsiteController,
                              icon: const Text('')),
                          spacer,
                          Row(
                            children: [
                              CustomTextWidget(
                                textSize: 18.sp,
                                fontFamily: '',
                                fontWeight: FontWeight.bold,
                                text: 'About this group',
                              ),
                              CustomTextWidget(
                                textSize: 12.sp,
                                fontFamily: '',
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                text: '  required',
                              ),
                            ],
                          ),
                          spacerSmall,
                          BigTextField(
                              hintText: 'Write more about this group',
                              controller: groupAboutController),
                          spacer,
                          CustomTextWidget(
                            textSize: 18.sp,
                            fontFamily: '',
                            fontWeight: FontWeight.bold,
                            text: 'Social links',
                          ),
                          spacerSmall,
                          SocialLinksWidget(
                            icon: FontAwesomeIcons.facebook,
                            hintText: 'Facebook profile link',
                            controller: facebookController,
                          ),
                          spacerSmall,
                          SocialLinksWidget(
                            icon: FontAwesomeIcons.xTwitter,
                            hintText: 'X profile link',
                            controller: xController,
                          ),
                          spacerSmall,
                          SocialLinksWidget(
                            icon: FontAwesomeIcons.instagram,
                            hintText: 'Instagram profile link',
                            controller: instagramController,
                          ),
                          spacerSmall,
                          SocialLinksWidget(
                            icon: FontAwesomeIcons.tiktok,
                            hintText: 'TikTok profile link',
                            controller: tiktokController,
                          ),
                          spacerSmall,
                          SocialLinksWidget(
                              icon: FontAwesomeIcons.pinterest,
                              hintText: 'Pinterest profile link',
                              controller: pinterestController),

                          spacerSmall,
                          SocialLinksWidget(
                            icon: FontAwesomeIcons.steam,
                            hintText: 'Steam profile link',
                            controller: steamController,
                          ),
                          spacerSmall,
                          SocialLinksWidget(
                            icon: FontAwesomeIcons.linkedin,
                            hintText: 'LinkedIn profile link',
                            controller: linkedInController,
                          ),
                          spacer,
                          CustomTextWidget(
                            textSize: 18.sp,
                            fontFamily: '',
                            fontWeight: FontWeight.bold,
                            text: 'Select Privacy',
                          ),
                          spacerSmall,
                          Row(
                            children: [
                              Switch(
                                  value: true,
                                  onChanged: (value) {},
                                  activeTrackColor: AppColors.kPrimaryColor2,
                                  activeColor: Colors.white),
                              SizedBox(
                                width: 10.w,
                              ),
                              CustomTextWidget(
                                textSize: 18.sp,
                                fontFamily: '',
                                fontWeight: FontWeight.bold,
                                text: 'Group will be public',
                              ),
                            ],
                          ),
                          spacer,
                          CustomButton(
                              buttonText: 'Submit Group',
                              height: 40.h,
                              color: AppColors.kPrimaryColor,
                              borderRadius: 10.r,
                              onTap: () async {
                                if (groupAboutController.text.trim().isEmpty ||
                                    groupCategoryController.text
                                        .trim()
                                        .isEmpty ||
                                    groupWebsiteController.text
                                        .trim()
                                        .isEmpty ||
                                    groupNameController.text.trim().isEmpty ||
                                    selectedCoverPathNotifier.value == null ||
                                    selectedProfilePathNotifier.value == null) {
                                  GoRouter.of(context).pop();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'All required fields should be filled',
                                        style: TextStyle(fontSize: 13.sp),
                                      ),
                                      backgroundColor:
                                          ThemeCubit().state == ThemeState.dark
                                              ? Colors.white
                                              : Colors.black,
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    isLoading = true; // Show loading indicator
                                  });

                                  try {
                                    await context
                                        .read<CreateGroupCubit>()
                                        .createGroup(
                                          name: groupNameController.text.trim(),
                                          category: groupCategoryController.text
                                              .trim(),
                                          website: groupWebsiteController.text
                                              .trim(),
                                          about:
                                              groupAboutController.text.trim(),
                                          facebook:
                                              facebookController.text.trim(),
                                          tiktok: tiktokController.text.trim(),
                                          x: xController.text.trim(),
                                          instagram:
                                              instagramController.text.trim(),
                                          pinterest:
                                              pinterestController.text.trim(),
                                          steam: steamController.text.trim(),
                                          linkedin:
                                              linkedInController.text.trim(),
                                          profileImg: File(
                                              selectedProfilePathNotifier
                                                  .value!),
                                          coverImg: File(
                                              selectedCoverPathNotifier.value!),
                                        );
                                    print('Group submitted successfully');
                                  } catch (e) {
                                    print('Error creating Group: $e');
                                  } finally {
                                    setState(() {
                                      isLoading =
                                          false; // Hide loading indicator
                                    });
                                    GoRouter.of(context).pop();
                                    refresh();
                                  }
                                }
                              }),
                          spacer,
                        ],
                      ),
                    ),
                  ),
                ),
                if (isLoading)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.kPrimaryColor,
                        ),
                      ),
                    ),
                  )
              ],
            );
          }),
        );
      });
}
