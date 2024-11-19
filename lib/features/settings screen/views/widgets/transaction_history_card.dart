import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/settings%20screen/data/models/transactions_model.dart';
import 'package:intl/intl.dart';

import '../../../../core/localization/all_app_strings.dart';

class TransactionHistoryCard extends StatelessWidget {
  final bool isNightMode;
  final TransactionModel transactionsModel;
  const TransactionHistoryCard({
    super.key,
    required this.isNightMode,
    required this.transactionsModel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ThemeCubit().state == ThemeState.dark
          ? DarkModeColors.kItemColorDark
          : AppColors.kAppBar2Color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TXN ID',
                style: TextStyle(fontSize: 12.sp),
              ),
              Text(
                  style: TextStyle(
                    fontSize: 11.sp,
                  ),
                  '#${transactionsModel.id}'),
            ],
          ),
          const Icon(
            Icons.arrow_upward,
            color: Colors.green,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transactionsModel.name,
                style: TextStyle(fontSize: 12.sp),
              ),
              Text(
                  style: TextStyle(
                    fontSize: 11.sp,
                  ),
                  DateFormat('MMMM').format(transactionsModel.createdAt)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppStrings.status.getString(context),
                style: TextStyle(fontSize: 12.sp),
              ),
              Text(
                  style: TextStyle(fontSize: 12.sp, color: Colors.blue),
                  transactionsModel.status),
              Text(
                '+ ${transactionsModel.newCoins}',
                style:
                    TextStyle(fontSize: 12.sp, color: AppColors.kPrimaryColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
