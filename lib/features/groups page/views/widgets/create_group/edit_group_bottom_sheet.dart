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
import 'package:genix/features/groups%20page/view%20model/get_group_by_id/get_group_by_id_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/update_group_details/update_group_details_cubit.dart';
import 'package:genix/features/groups%20page/views/widgets/create_group/group_category_menu.dart';
import 'package:genix/features/groups%20page/views/widgets/create_group/social_link_widget.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/localization/all_app_strings.dart';

Future<dynamic> editGroupBottomSheet(
  BuildContext context,
  Function() refresh,
  int id,
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
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UpdateGroupDetailsCubit(),
          ),
          BlocProvider(
            create: (context) => GetGroupByIdCubit()..getGroupById(id: id),
          ),
        ],
        child: BlocBuilder<GetGroupByIdCubit, GetGroupByIdState>(
          builder: (context, state) {
            if (state is GetGroupByIdSuccess) {
              // Now data has been successfully fetched
              TextEditingController groupNameController =
                  TextEditingController(text: state.group.data?.group?.name);
              TextEditingController groupCategoryController =
                  TextEditingController(
                      text: state.group.data?.group?.category);
              TextEditingController groupWebsiteController =
                  TextEditingController(text: state.group.data?.group?.website);
              TextEditingController groupAboutController =
                  TextEditingController(text: state.group.data?.group?.about);
              TextEditingController facebookController = TextEditingController(
                  text: state.group.data?.group?.socialFacebook);
              TextEditingController xController = TextEditingController(
                  text: state.group.data?.group?.socialTwitter);
              TextEditingController instagramController = TextEditingController(
                  text: state.group.data?.group?.socialInstagram);
              TextEditingController tiktokController = TextEditingController(
                  text: state.group.data?.group?.socialTiktok);
              TextEditingController pinterestController = TextEditingController(
                  text: state.group.data?.group?.socialPinterest);
              TextEditingController steamController = TextEditingController(
                  text: state.group.data?.group?.socialSteam);
              TextEditingController linkedInController = TextEditingController(
                  text: state.group.data?.group?.socialLinkedin);

              return StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
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
                                      text: '${AppStrings.groupnmae.getString(context)}',
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
                                    hintText: '${AppStrings.groupnmae.getString(context)}',
                                    controller: groupNameController,
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
                                      text:'${AppStrings.required.getString(context)}',
                                    ),
                                  ],
                                ),
                                spacerSmall,
                                CustomDropdownMenu(
                                  categoryController: groupCategoryController,
                                ),
                                spacer,
                                Row(
                                  children: [
                                    CustomTextWidget(
                                      textSize: 18.sp,
                                      fontFamily: '',
                                      fontWeight: FontWeight.bold,
                                      text:'${AppStrings.website.getString(context)}',
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
                                    hintText: '${AppStrings.validwebsiteurl.getString(context)}',
                                    controller: groupWebsiteController,
                                    icon: const Text('')),
                                spacer,
                                Row(
                                  children: [
                                    CustomTextWidget(
                                      textSize: 18.sp,
                                      fontFamily: '',
                                      fontWeight: FontWeight.bold,
                                      text: '${AppStrings.aboutthisgroup.getString(context)}',
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
                                    hintText: '${AppStrings.writemoreaboutthisgroup.getString(context)}',
                                    controller: groupAboutController),
                                spacer,
                                CustomTextWidget(
                                  textSize: 18.sp,
                                  fontFamily: '',
                                  fontWeight: FontWeight.bold,
                                  text: '${AppStrings.sociallinks.getString(context)}',
                                ),
                                spacerSmall,
                                SocialLinksWidget(
                                  icon: FontAwesomeIcons.facebook,
                                  hintText: '${AppStrings.facebookprofilelink.getString(context)}',
                                  controller: facebookController,
                                ),
                                spacerSmall,
                                SocialLinksWidget(
                                  icon: FontAwesomeIcons.xTwitter,
                                  hintText: '${AppStrings.xprofilelink.getString(context)}',
                                  controller: xController,
                                ),
                                spacerSmall,
                                SocialLinksWidget(
                                  icon: FontAwesomeIcons.instagram,
                                  hintText: '${AppStrings.instagramprofilelink.getString(context)}',
                                  controller: instagramController,
                                ),
                                spacerSmall,
                                SocialLinksWidget(
                                  icon: FontAwesomeIcons.tiktok,
                                  hintText: '${AppStrings.tiktokprofilelink.getString(context)}',
                                  controller: tiktokController,
                                ),
                                spacerSmall,
                                SocialLinksWidget(
                                    icon: FontAwesomeIcons.pinterest,
                                    hintText:'${AppStrings.pinterestprofilelink.getString(context)}',
                                    controller: pinterestController),
                                spacerSmall,
                                SocialLinksWidget(
                                  icon: FontAwesomeIcons.steam,
                                  hintText:'${AppStrings.steamprofilelink.getString(context)}',
                                  controller: steamController,
                                ),
                                spacerSmall,
                                SocialLinksWidget(
                                  icon: FontAwesomeIcons.linkedin,
                                  hintText: '${AppStrings.linkedInprofilelink.getString(context)}',
                                  controller: linkedInController,
                                ),
                                spacer,
                                CustomTextWidget(
                                  textSize: 18.sp,
                                  fontFamily: '',
                                  fontWeight: FontWeight.bold,
                                  text: '${AppStrings.selectprivacy.getString(context)}',
                                ),
                                spacerSmall,
                                Row(
                                  children: [
                                    Switch(
                                        value: isPrivate,
                                        onChanged: (value) {
                                          setState(() {
                                            isPrivate = !isPrivate;
                                          });
                                        },
                                        activeTrackColor:
                                            AppColors.kPrimaryColor2,
                                        activeColor: Colors.white),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    CustomTextWidget(
                                      textSize: 18.sp,
                                      fontFamily: '',
                                      fontWeight: FontWeight.bold,
                                      text: '${AppStrings.groupwillbepublic.getString(context)}',
                                    ),
                                  ],
                                ),
                                spacer,
                                CustomButton(
                                    buttonText: '${AppStrings.submitgroup.getString(context)}',
                                    height: 40.h,
                                    color: AppColors.kPrimaryColor,
                                    borderRadius: 10.r,
                                    onTap: () async {
                                      if (groupAboutController.text
                                              .trim()
                                              .isEmpty ||
                                          groupCategoryController.text
                                              .trim()
                                              .isEmpty ||
                                          groupWebsiteController.text
                                              .trim()
                                              .isEmpty ||
                                          groupNameController.text
                                              .trim()
                                              .isEmpty) {
                                        GoRouter.of(context).pop();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text('${AppStrings.allrequiredfieldsshouldbefilled.getString(context)}',
                                              style: TextStyle(fontSize: 13.sp),
                                            ),
                                            backgroundColor:
                                                ThemeCubit().state ==
                                                        ThemeState.dark
                                                    ? Colors.white
                                                    : Colors.black,
                                            duration:
                                                const Duration(seconds: 2),
                                          ),
                                        );
                                      } else {
                                        setState(() {
                                          isLoading =
                                              true; // Show loading indicator
                                        });

                                        try {
                                          await context
                                              .read<UpdateGroupDetailsCubit>()
                                              .updateGroup(
                                                isPrivate: !isPrivate,
                                                id: state.group.data?.group
                                                        ?.id ??
                                                    0,
                                                name: groupNameController.text
                                                    .trim(),
                                                category:
                                                    groupCategoryController.text
                                                        .trim(),
                                                website: groupWebsiteController
                                                    .text
                                                    .trim(),
                                                about: groupAboutController.text
                                                    .trim(),
                                                facebook: facebookController
                                                    .text
                                                    .trim(),
                                                tiktok: tiktokController.text
                                                    .trim(),
                                                x: xController.text.trim(),
                                                instagram: instagramController
                                                    .text
                                                    .trim(),
                                                pinterest: pinterestController
                                                    .text
                                                    .trim(),
                                                steam:
                                                    steamController.text.trim(),
                                                linkedin: linkedInController
                                                    .text
                                                    .trim(),
                                                profileImg: File(''),
                                                coverImg: File(''),
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
                        ),
                    ],
                  );
                },
              );
            } else if (state is GetGroupByIdError) {
              return  Center(child: Text('${AppStrings.errorloadinggroupdata.getString(context)}'));
            } else {
              return const Center(
                  child: CircularProgressIndicator(
                color: AppColors.kPrimaryColor,
              ));
            }
          },
        ),
      );
    },
  );
}
