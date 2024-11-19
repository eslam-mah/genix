import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/images.dart';
import 'package:genix/core/widgets/custom_user_profile_image.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customtextfield.dart';
import 'package:genix/features/drawer/view/widget/drawer_profile_shimmer.dart';
import 'package:genix/features/home%20screen/views/view/homebody.dart';
import 'package:genix/features/lock%20screen/view%20model/get%20lock/get_lock_cubit.dart';
import 'package:genix/features/lock%20screen/view%20model/remove%20lock/remove_lock_cubit.dart';
import 'package:genix/features/splash%20screen/view%20model/first%20load/first_load_cubit.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../core/localization/all_app_strings.dart';

class LockPage extends StatefulWidget {
  const LockPage({super.key});
  static const String route = '/lock';

  @override
  State<LockPage> createState() => _LockPageState();
}

class _LockPageState extends State<LockPage> {
  TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    context.read<FirstLoadCubit>().firstLoad();
    context.read<GetLockCubit>().getLock();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RemoveLockCubit, RemoveLockState>(
          listener: (context, state) {
            if (state is RemoveLockLoading) {
              setState(() => _isLoading = true);
            } else {
              setState(() => _isLoading = false);
            }

            if (state is RemoveLockSuccess) {
              GoRouter.of(context).push(HomePage.routeName);
            } else if (state is RemoveLockError) {
              ScaffoldMessenger.of(context).showSnackBar(
                 SnackBar(content: Text('${AppStrings.failedtoremovelock.getString(context)}')),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        body: ModalProgressHUD(
          inAsyncCall: _isLoading,
          progressIndicator: const CircularProgressIndicator(
            color: AppColors.kPrimaryColor,
          ),
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    AppGifs.lockBackground), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<FirstLoadCubit, FirstLoadState>(
                    builder: (context, state) {
                  if (state is FirstLoadSuccess) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomUserProfileImage(
                            image: state.firstLoad.data.user?.profileImg ?? '',
                            isActive:
                                state.firstLoad.data.user?.isActive ?? false,
                            showname: state.firstLoad.data.user?.showname ?? '',
                          ),
                          SizedBox(width: 10.w),
                          Text(
                            state.firstLoad.data.user?.showname ?? '',
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const DrawerProfileShimmer();
                  }
                }),
                SizedBox(height: 20.h),
                CustomTextField(
                  hintText: '${AppStrings.password.getString(context)}',
                  readOnly: false,
                  onTap: () {},
                  controller: passwordController,
                  isObscure: true,
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: CustomButton(
                    buttonText: '${AppStrings.unlock.getString(context)}',
                    height: 40.h,
                    borderRadius: 10.r,
                    color: const Color.fromARGB(255, 106, 28, 22),
                    onTap: () async {
                      await context
                          .read<RemoveLockCubit>()
                          .removeLock(password: passwordController.text.trim());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
