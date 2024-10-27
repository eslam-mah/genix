import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';

import 'package:genix/features/pages%20screen/data/models/page_profile_model/page_profile_model.dart';
import 'package:genix/features/pages%20screen/view%20model/follow_page/follow_page_cubit.dart';
import 'package:genix/features/pages%20screen/view%20model/remove_follow_page/remove_follow_page_cubit.dart';

class FollowPageButton extends StatefulWidget {
  final PageProfileModel pageProfileModel;
  const FollowPageButton({
    super.key,
    required this.pageProfileModel,
  });

  @override
  State<FollowPageButton> createState() => _FollowPageButtonState();
}

class _FollowPageButtonState extends State<FollowPageButton> {
  late ValueNotifier<bool> isJoinedNotifier;

  @override
  void initState() {
    super.initState();
    isJoinedNotifier = ValueNotifier(
      widget.pageProfileModel.data?.page?.me?.member?.id != null,
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
                buttonText: 'Page Followed',
                icon: const Icon(
                  Icons.verified,
                  color: Colors.white,
                ),
                height: 20.h,
                width: 140.w,
                color: AppColors.kPrimaryColor,
                borderRadius: 8.r,
                onTap: () {
                  context
                      .read<RemoveFollowPageCubit>()
                      .removeFollowPage(
                          id: widget.pageProfileModel.data?.page?.id ?? 0)
                      .then((onValue) {
                    isJoinedNotifier.value = false;
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Page leaved successfully',
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
                buttonText: 'Join Page',
                height: 20.h,
                width: 100.w,
                color: AppColors.kPrimaryColor2,
                borderRadius: 8.r,
                onTap: () {
                  context
                      .read<FollowPageCubit>()
                      .followPage(
                          id: widget.pageProfileModel.data?.page?.id ?? 0)
                      .then((onValue) {
                    isJoinedNotifier.value = true;
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Page joined successfully',
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
