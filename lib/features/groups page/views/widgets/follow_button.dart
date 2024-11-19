import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/groups%20page/data/models/group_profile_model/group_profile_model.dart';
import 'package:genix/features/groups%20page/view%20model/join_group_cubit/join_group_cubit.dart';
import 'package:genix/features/groups%20page/view%20model/remove_join_group/remove_join_group_cubit.dart';

import '../../../../core/localization/all_app_strings.dart';

class FollowButton extends StatefulWidget {
  final GroupProfileModel groupProfileModel;
  const FollowButton({
    super.key,
    required this.groupProfileModel,
  });

  @override
  State<FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  late ValueNotifier<bool> isJoinedNotifier;

  @override
  void initState() {
    super.initState();
    isJoinedNotifier = ValueNotifier(
      widget.groupProfileModel.data?.group?.me?.member?.id != null,
    );
  }

  @override
  void dispose() {
    isJoinedNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isJoinedNotifier,
      builder: (context, isJoined, _) {
        return isJoined
            ? CustomButton(
                buttonText: '${AppStrings.joinedgroup.getString(context)}',
                icon: const Icon(
                  Icons.verified,
                  color: Colors.white,
                ),
                height: 20.h,
                width: 130.w,
                color: AppColors.kPrimaryColor,
                borderRadius: 8.r,
                onTap: () {
                  context
                      .read<RemoveJoinGroupCubit>()
                      .removeJoinGroup(
                          id: widget.groupProfileModel.data?.group?.id ?? 0)
                      .then((onValue) {
                    isJoinedNotifier.value = false;
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${AppStrings.leavegroupsuccessfully.getString(context)}',
                            style: TextStyle(fontSize: 13.sp)),
                        backgroundColor: ThemeCubit().state == ThemeState.dark
                            ? Colors.white
                            : Colors.black,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  });
                })
            : CustomButton(
                buttonText: '${AppStrings.joingroup.getString(context)}',
                height: 20.h,
                width: 100.w,
                color: AppColors.kPrimaryColor2,
                borderRadius: 8.r,
                onTap: () {
                  context
                      .read<JoinGroupCubit>()
                      .joinGroup(
                          id: widget.groupProfileModel.data?.group?.id ?? 0)
                      .then((onValue) {
                    isJoinedNotifier.value = true;
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${AppStrings.groupjoinedsuccessfully.getString(context)}',
                            style: TextStyle(fontSize: 13.sp)),
                        backgroundColor: ThemeCubit().state == ThemeState.dark
                            ? Colors.white
                            : Colors.black,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  });
                });
      },
    );
  }
}
