import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/splash%20screen/view%20model/first%20load/first_load_cubit.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/localization/all_app_strings.dart';

class BalanceAndRevenueCard extends StatefulWidget {
  const BalanceAndRevenueCard({
    super.key,
  });

  @override
  State<BalanceAndRevenueCard> createState() => _BalanceAndRevenueCardState();
}

class _BalanceAndRevenueCardState extends State<BalanceAndRevenueCard> {
  @override
  void initState() {
    super.initState();
    context.read<FirstLoadCubit>().firstLoad();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirstLoadCubit, FirstLoadState>(
      builder: (context, state) {
        if (state is FirstLoadSuccess) {
          return Container(
            padding: EdgeInsets.all(5.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.grey.withOpacity(0.5))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppStrings.currentbalancecap.getString(context),
                          style: TextStyle(fontSize: 13.sp)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.coins,
                            color: Color.fromARGB(255, 233, 211, 13),
                            size: 20.r,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Text(
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              '${state.firstLoad.data.user?.coins ?? 0}',
                              style: TextStyle(
                                  fontSize: 17.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 150.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(AppStrings.revenuefromshortscap.getString(context),
                          style: TextStyle(fontSize: 15.sp)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            FontAwesomeIcons.euroSign,
                            color: Colors.green,
                            size: 20.r,
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: Text(
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              '${state.firstLoad.data.user?.revenue ?? 0}',
                              style: TextStyle(
                                  fontSize: 17.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: 60.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5.r),
                                color: Colors.grey),
                            child: Text(
                              AppStrings.withdrawcap.getString(context),
                              style: TextStyle(fontSize: 10.sp),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return Shimmer.fromColors(
            baseColor: ThemeCubit().state == ThemeState.dark
                ? Colors.grey[800]!
                : Colors.grey[300]!,
            highlightColor: ThemeCubit().state == ThemeState.dark
                ? Colors.grey[600]!
                : Colors.grey[100]!,
            child: Row(
              children: [
                Container(
                  width: 150.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: ThemeCubit().state == ThemeState.dark
                        ? Colors.grey[700]
                        : Colors.grey[300],
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  width: 150.w,
                  height: 80.h,
                  decoration: BoxDecoration(
                    color: ThemeCubit().state == ThemeState.dark
                        ? Colors.grey[700]
                        : Colors.grey[300],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
