import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/customeditingprofilewidget.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/profile%20screen/data/profile_model/profile_model.dart';
import 'package:genix/features/profile%20screen/view%20model/add%20friend/add_friend_cubit.dart';
import 'package:genix/features/profile%20screen/view%20model/remove%20friend/remove_friend_cubit.dart';
import 'package:genix/features/profile%20screen/views/widgets/custom_icon_counter.dart';
import 'package:genix/features/profile%20screen/views/widgets/edit_background_pic.dart';
import 'package:genix/features/profile%20screen/views/widgets/edit_profile_pic.dart';

import '../../../../core/localization/all_app_strings.dart';

class CustomProfileHeader extends StatefulWidget {
  CustomProfileHeader({
    super.key,
    required this.isProfileEditorShown,
    this.refresh,
    required this.profileModel,
  });

  final bool isProfileEditorShown;
  final ProfileModel profileModel;
  final Function()? refresh;

  @override
  State<CustomProfileHeader> createState() => _CustomProfileHeaderState();
}

class _CustomProfileHeaderState extends State<CustomProfileHeader> {
  late ValueNotifier<bool> isFriendNotifier;

  @override
  void initState() {
    super.initState();
    isFriendNotifier = ValueNotifier(
      widget.profileModel.data?.user?.id ==
          widget.profileModel.data?.myFollowing?.user?.id,
    );
  }

  @override
  void dispose() {
    isFriendNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: 400.h,
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            errorWidget: (context, error, stackTrace) {
              return Container(
                  alignment: Alignment.center, child: const SizedBox());
            },
            imageUrl: widget.profileModel.data?.user?.coverImg ?? "",
          ),
        ),
        Positioned(
          top: 40.h,
          left: 0,
          right: 0,
          child: SizedBox(
            height: 300.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomUserProfileEditingImage(
                  size: 37.r,
                  smallSize: 10.r,
                  fontSize: 30.sp,
                  positionBottom: 1.h,
                  positionRight: 7.w,
                  whiteSize: 0,
                  icon: FontAwesomeIcons.pen,
                  onTapIcon: () {
                    editProfilePicBottomSheet(context, widget.refresh);
                  },
                  imageUrl: widget.profileModel.data?.user?.profileImg ?? "",
                  isProfileEditorShown: widget.isProfileEditorShown,
                  textPlaceHolder: Text(
                      widget.profileModel.data?.user?.showname!
                              .split('')
                              .take(2)
                              .join()
                              .toUpperCase() ??
                          "",
                      style: TextStyle(fontSize: 35.sp)),
                ),
                Text(
                  widget.profileModel.data?.user?.showname ?? '',
                  style: TextStyle(
                    shadows: [
                      Shadow(
                        color: ThemeCubit().state == ThemeState.dark
                            ? Colors.black
                            : Colors.white,
                        blurRadius: 10.r,
                      ),
                      Shadow(
                        color: ThemeCubit().state == ThemeState.dark
                            ? Colors.black
                            : Colors.white,
                        blurRadius: 10.r,
                      ),
                      Shadow(
                        color: ThemeCubit().state == ThemeState.dark
                            ? Colors.black
                            : Colors.white,
                        blurRadius: 10.r,
                      )
                    ],
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                widget.isProfileEditorShown
                    ? SizedBox.shrink()
                    : ValueListenableBuilder<bool>(
                        valueListenable: isFriendNotifier,
                        builder: (context, isFriend, _) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              isFriend
                                  ? IconButton(
                                      onPressed: () {
                                        context
                                            .read<RemoveFriendCubit>()
                                            .removeFriend(
                                                uid: widget.profileModel.data
                                                        ?.myFollowing?.id ??
                                                    0)
                                            .then((onValue) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  AppStrings.followremovedsuccessfully.getString(context),
                                                  style: TextStyle(
                                                      fontSize: 13.sp)),
                                              backgroundColor:
                                                  ThemeCubit().state ==
                                                          ThemeState.dark
                                                      ? Colors.white
                                                      : Colors.black,
                                              duration:
                                                  const Duration(seconds: 2),
                                            ),
                                          );
                                          isFriendNotifier.value = false;
                                        });
                                      },
                                      icon: CircleAvatar(
                                        backgroundColor: Colors.red,
                                        radius: 15.r,
                                        child: Icon(
                                          FontAwesomeIcons.userMinus,
                                          size: 15.r,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        context
                                            .read<AddFriendCubit>()
                                            .addFriend(
                                              uid: widget.profileModel.data
                                                      ?.user?.id ??
                                                  0,
                                            )
                                            .then((onValue) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  AppStrings.followaddedsuccessfully.getString(context),
                                                  style: TextStyle(
                                                      fontSize: 13.sp)),
                                              backgroundColor:
                                                  ThemeCubit().state ==
                                                          ThemeState.dark
                                                      ? Colors.white
                                                      : Colors.black,
                                              duration:
                                                  const Duration(seconds: 2),
                                            ),
                                          );
                                          isFriendNotifier.value = true;
                                        });
                                      },
                                      icon: CircleAvatar(
                                        backgroundColor: Colors.green,
                                        radius: 15.r,
                                        child: Icon(
                                          FontAwesomeIcons.userPlus,
                                          size: 15.r,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                              IconButton(
                                onPressed: () {
                                  // todo: menu dialog
                                },
                                icon: CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 15.r,
                                  child: Icon(
                                    FontAwesomeIcons.ellipsis,
                                    size: 15.r,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(5.r)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Text(
                      widget.profileModel.data?.user?.bio ?? "",
                      style: TextStyle(fontSize: 15.sp, color: Colors.white),
                    ),
                  ),
                ),
                widget.isProfileEditorShown
                    ? IconButton(
                        onPressed: () {
                          editBackgroundPicBottomSheet(context, widget.refresh);
                        },
                        icon: CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 15.r,
                          child: Icon(
                            FontAwesomeIcons.pen,
                            size: 15.r,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
        Positioned(
            top: 360.h,
            left: 33.w,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.kPrimaryColor2,
                  borderRadius: BorderRadius.circular(8.r)),
              child: Row(
                children: [
                  CustomCounterIcon(
                    icon: FontAwesomeIcons.users,
                    number:
                        widget.profileModel.data?.followersCount?.toInt() ?? 0,
                  ),
                  CustomCounterIcon(
                    icon: FontAwesomeIcons.userPlus,
                    number:
                        widget.profileModel.data?.followingCount?.toInt() ?? 0,
                  ),
                  CustomCounterIcon(
                      icon: FontAwesomeIcons.solidHeart,
                      number:
                          widget.profileModel.data?.reactionsCount?.toInt() ??
                              0),
                  CustomCounterIcon(
                    icon: FontAwesomeIcons.clipboardUser,
                    number: widget.profileModel.data?.postsCount?.toInt() ?? 0,
                  ),
                ],
              ),
            ))
      ],
    );
  }
}
