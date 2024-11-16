import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
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

import '../../../../../core/localization/all_app_strings.dart';

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
                                text:'${AppStrings.pagename.getString(context)}',
                              ),
                              CustomTextWidget(
                                textSize: 12.sp,
                                fontFamily: '',
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                text: '${AppStrings.required.getString(context)}',
                              ),
                            ],
                          ),
                          spacerSmall,
                          CustomTextField2(
                              readOnly: false,
                              hintText: '${AppStrings.pagename.getString(context)}',
                              controller: pageNameController,
                              icon: const Text('')),
                          spacer,
                          Row(
                            children: [
                              CustomTextWidget(
                                textSize: 18.sp,
                                fontFamily: '',
                                fontWeight: FontWeight.bold,
                                text: '${AppStrings.category.getString(context)}',
                              ),
                              CustomTextWidget(
                                textSize: 12.sp,
                                fontFamily: '',
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                text: '${AppStrings.required.getString(context)}',
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
                                text: '${AppStrings.website.getString(context)}',
                              ),
                              CustomTextWidget(
                                textSize: 12.sp,
                                fontFamily: '',
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                text: '${AppStrings.required.getString(context)}',
                              ),
                            ],
                          ),
                          spacerSmall,
                          CustomTextField2(
                              readOnly: false,
                              hintText:'${AppStrings.validwebsiteurl.getString(context)}',
                              controller: pageWebsiteController,
                              icon: const Text('')),
                          spacer,
                          Row(
                            children: [
                              CustomTextWidget(
                                textSize: 18.sp,
                                fontFamily: '',
                                fontWeight: FontWeight.bold,
                                text: '${AppStrings.aboutthispage.getString(context)}',
                              ),
                              CustomTextWidget(
                                textSize: 12.sp,
                                fontFamily: '',
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                text: '${AppStrings.required.getString(context)}',
                              ),
                            ],
                          ),
                          spacerSmall,
                          BigTextField(
                              hintText: '${AppStrings.writemoreaboutthispage.getString(context)}',
                              controller: pageAboutController),
                          spacer,
                          CustomTextWidget(
                            textSize: 18.sp,
                            fontFamily: '',
                            fontWeight: FontWeight.bold,
                            text: '${AppStrings.sociallinks.getString(context)}',
                          ),
                          spacerSmall,
                          SocialLinksPageWidget(
                            icon: FontAwesomeIcons.facebook,
                            hintText:'${AppStrings.facebookprofilelink.getString(context)}',
                            controller: facebookController,
                          ),
                          spacerSmall,
                          SocialLinksPageWidget(
                            icon: FontAwesomeIcons.xTwitter,
                            hintText: '${AppStrings.xprofilelink.getString(context)}',
                            controller: xController,
                          ),
                          spacerSmall,
                          SocialLinksPageWidget(
                            icon: FontAwesomeIcons.instagram,
                            hintText: '${AppStrings.instagramprofilelink.getString(context)}',
                            controller: instagramController,
                          ),
                          spacerSmall,
                          SocialLinksPageWidget(
                            icon: FontAwesomeIcons.tiktok,
                            hintText: '${AppStrings.tiktokprofilelink.getString(context)}',
                            controller: tiktokController,
                          ),
                          spacerSmall,
                          SocialLinksPageWidget(
                              icon: FontAwesomeIcons.pinterest,
                              hintText: '${AppStrings.pinterestprofilelink.getString(context)}',
                              controller: pinterestController),

                          spacerSmall,
                          SocialLinksPageWidget(
                            icon: FontAwesomeIcons.steam,
                            hintText: '${AppStrings.steamprofilelink.getString(context)}',
                            controller: steamController,
                          ),
                          spacerSmall,
                          SocialLinksPageWidget(
                            icon: FontAwesomeIcons.linkedin,
                            hintText: '${AppStrings.linkedInprofilelink.getString(context)}',
                            controller: linkedInController,
                          ),
                          spacer,
                          CustomTextWidget(
                            textSize: 18.sp,
                            fontFamily: '',
                            fontWeight: FontWeight.bold,
                            text:'${AppStrings.selectprivacy.getString(context)}',
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
                                text: '${AppStrings.pagewillbepublic.getString(context)}',
                              ),
                            ],
                          ),
                          spacer,
                          CustomButton(
                              buttonText: '${AppStrings.submitpage.getString(context)}',
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
                                      content: Text('${AppStrings.allrequiredfieldsshouldbefilled.getString(context)}',
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
