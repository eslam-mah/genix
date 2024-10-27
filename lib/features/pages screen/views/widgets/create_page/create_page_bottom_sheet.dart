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

import 'package:genix/features/pages%20screen/view%20model/create_page/create_page_cubit.dart';
import 'package:genix/features/pages%20screen/views/widgets/create_page/page_category_menu.dart';
import 'package:genix/features/pages%20screen/views/widgets/create_page/select_image_widget_page.dart';
import 'package:genix/features/pages%20screen/views/widgets/create_page/social_link_widget_page.dart';
import 'package:go_router/go_router.dart';

Future<dynamic> createPageBottomSheet(
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
        bool isPrivate = true;
        return BlocProvider(
          create: (context) => CreatePageCubit(),
          child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            ValueNotifier<String?> selectedProfilePathNotifier =
                ValueNotifier<String?>(null);
            ValueNotifier<String?> selectedCoverPathNotifier =
                ValueNotifier<String?>(null);
            TextEditingController pageNameController = TextEditingController();
            TextEditingController pageCategoryController =
                TextEditingController();
            TextEditingController pageWebsiteController =
                TextEditingController();
            TextEditingController pageAboutController = TextEditingController();
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
                                text: 'Page name',
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
                              hintText: 'Page name',
                              controller: pageNameController,
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
                          CustomPageDropdownMenu(
                            categoryController: pageCategoryController,
                          ),
                          spacer,
                          SelectImagePage(
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
                              controller: pageWebsiteController,
                              icon: const Text('')),
                          spacer,
                          Row(
                            children: [
                              CustomTextWidget(
                                textSize: 18.sp,
                                fontFamily: '',
                                fontWeight: FontWeight.bold,
                                text: 'About this page',
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
                              hintText: 'Write more about this page',
                              controller: pageAboutController),
                          spacer,
                          CustomTextWidget(
                            textSize: 18.sp,
                            fontFamily: '',
                            fontWeight: FontWeight.bold,
                            text: 'Social links',
                          ),
                          spacerSmall,
                          SocialLinksPageWidget(
                            icon: FontAwesomeIcons.facebook,
                            hintText: 'Facebook profile link',
                            controller: facebookController,
                          ),
                          spacerSmall,
                          SocialLinksPageWidget(
                            icon: FontAwesomeIcons.xTwitter,
                            hintText: 'X profile link',
                            controller: xController,
                          ),
                          spacerSmall,
                          SocialLinksPageWidget(
                            icon: FontAwesomeIcons.instagram,
                            hintText: 'Instagram profile link',
                            controller: instagramController,
                          ),
                          spacerSmall,
                          SocialLinksPageWidget(
                            icon: FontAwesomeIcons.tiktok,
                            hintText: 'TikTok profile link',
                            controller: tiktokController,
                          ),
                          spacerSmall,
                          SocialLinksPageWidget(
                              icon: FontAwesomeIcons.pinterest,
                              hintText: 'Pinterest profile link',
                              controller: pinterestController),

                          spacerSmall,
                          SocialLinksPageWidget(
                            icon: FontAwesomeIcons.steam,
                            hintText: 'Steam profile link',
                            controller: steamController,
                          ),
                          spacerSmall,
                          SocialLinksPageWidget(
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
                                  value: isPrivate,
                                  onChanged: (value) {
                                    isPrivate = !isPrivate;
                                  },
                                  activeTrackColor: AppColors.kPrimaryColor2,
                                  activeColor: Colors.white),
                              SizedBox(
                                width: 10.w,
                              ),
                              CustomTextWidget(
                                textSize: 18.sp,
                                fontFamily: '',
                                fontWeight: FontWeight.bold,
                                text: 'Page will be public',
                              ),
                            ],
                          ),
                          spacer,
                          CustomButton(
                              buttonText: 'Submit Page',
                              height: 40.h,
                              color: AppColors.kPrimaryColor,
                              borderRadius: 10.r,
                              onTap: () async {
                                if (pageAboutController.text.trim().isEmpty ||
                                    pageCategoryController.text
                                        .trim()
                                        .isEmpty ||
                                    pageWebsiteController.text.trim().isEmpty ||
                                    pageNameController.text.trim().isEmpty ||
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
                                        .read<CreatePageCubit>()
                                        .createPage(
                                            name:
                                                pageNameController.text.trim(),
                                            category: pageCategoryController
                                                .text
                                                .trim(),
                                            website: pageWebsiteController.text
                                                .trim(),
                                            about:
                                                pageAboutController.text.trim(),
                                            facebook:
                                                facebookController.text.trim(),
                                            tiktok:
                                                tiktokController.text.trim(),
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
                                                selectedCoverPathNotifier
                                                    .value!),
                                            isPrivate: !isPrivate);
                                    print('Page submitted successfully');
                                  } catch (e) {
                                    print('Error creating Page: $e');
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
