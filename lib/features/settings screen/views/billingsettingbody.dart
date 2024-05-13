import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customheaderwidget2.dart';
import 'package:genix/core/widgets/customtextfield2.dart';
import 'package:genix/features/settings%20screen/widgets/balanceandrevenuecard.dart';
import 'package:genix/features/settings%20screen/widgets/custombillingwidget.dart';
import 'package:genix/features/settings%20screen/widgets/custombillingwidget2.dart';
import 'package:genix/features/settings%20screen/widgets/transactionhistorycard.dart';

class BillingAreaSettings extends StatefulWidget {
  const BillingAreaSettings({
    super.key,
    required this.isNightModeEnabled,
  });
  final bool isNightModeEnabled;

  @override
  State<BillingAreaSettings> createState() => _BillingAreaSettingsState();
}

class _BillingAreaSettingsState extends State<BillingAreaSettings> {
  int isSelected = 0;
  bool showTransactions = false;
  bool transactionDialoge = false;
  int selectedTransaction = 0;
  String selected = 'all transactions';
  String transName = 'transactions name';
  String transId = 'transaction id';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20.h,
                ),
                const CustomHeaderWidget2(text: 'Billing area'),
                SizedBox(
                  height: 20.h,
                ),
                const Text('BILLING AREA',
                    style: TextStyle(color: Colors.grey)),
                Text('Browse transactions and add more coins to your account',
                    style: TextStyle(color: Colors.black.withOpacity(0.6))),
                SizedBox(
                  height: 10.h,
                ),
                BalanceAndRevenueCard(),
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  'TOP UP',
                  style:
                      TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 15.h,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isSelected = isSelected == 1 ? 0 : 1;
                        });
                      },
                      child: CustomBillingWidget(
                          isSelected: isSelected,
                          numberSelected: 1,
                          coins: 10,
                          isNightModeEnabled: widget.isNightModeEnabled),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isSelected = isSelected == 2 ? 0 : 2;
                        });
                      },
                      child: CustomBillingWidget(
                          isSelected: isSelected,
                          numberSelected: 2,
                          coins: 50,
                          isNightModeEnabled: widget.isNightModeEnabled),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isSelected = isSelected == 3 ? 0 : 3;
                        });
                      },
                      child: CustomBillingWidget(
                          isSelected: isSelected,
                          numberSelected: 3,
                          coins: 1500,
                          isNightModeEnabled: widget.isNightModeEnabled),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isSelected = isSelected == 4 ? 0 : 4;
                        });
                      },
                      child: CustomBillingWidget(
                          isSelected: isSelected,
                          numberSelected: 4,
                          coins: 3500,
                          isNightModeEnabled: widget.isNightModeEnabled),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          isSelected = isSelected == 5 ? 0 : 5;
                        });
                      },
                      child: CustomBillingWidget(
                          isSelected: isSelected,
                          numberSelected: 5,
                          coins: 7000,
                          isNightModeEnabled: widget.isNightModeEnabled),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          isSelected = isSelected == 6 ? 0 : 6;
                        });
                      },
                      child: CustomBillingWidget(
                          isSelected: isSelected,
                          numberSelected: 6,
                          coins: 10000,
                          isNightModeEnabled: widget.isNightModeEnabled),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                CustomBillingWidget2(
                    isSelected: isSelected,
                    numberSelected: 7,
                    coins: 100,
                    isNightModeEnabled: widget.isNightModeEnabled)
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                CustomButton(
                    color: AppColors.kPrimaryColor2,
                    buttonText: 'Go to payment',
                    width: double.infinity,
                    height: 35.h,
                    borderRadius: 10.r,
                    onTap: () {}),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showTransactions = !showTransactions;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(13.r),
                  border: Border.all(
                    color: showTransactions
                        ? AppColors.kPrimaryColor2
                        : Colors.grey.withOpacity(0.4),
                    width: 2,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      FontAwesomeIcons.chevronDown,
                      size: 16.r,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      'SHOW LATEST TRANSACTIONS',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp, // Adjust size as needed
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Visibility(
              visible: showTransactions = showTransactions,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TRANSACTIONS',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20.sp),
                      ),
                      Text(
                          style:
                              TextStyle(color: Colors.black.withOpacity(0.6)),
                          'Track and view inbound or outbound transactions and get ready for your next achievements.'),
                      SizedBox(
                        height: 10.h,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            transactionDialoge = !transactionDialoge;
                          });

                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text(
                                          'Search Transaction by',
                                          style: TextStyle(
                                            fontSize: 20.sp,
                                          ),
                                        ),
                                        Container(
                                          width: double.infinity,
                                          height: 1.h,
                                          color: Colors.black.withOpacity(0.1),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedTransaction = 1;

                                              selected = 'all transactions';
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: ListTile(
                                            title:
                                                const Text('all transactions'),
                                            trailing: CircleAvatar(
                                                radius: 9.r,
                                                backgroundColor:
                                                    selectedTransaction == 1
                                                        ? AppColors
                                                            .kPrimaryColor2
                                                        : Colors.grey
                                                            .withOpacity(0.4)),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedTransaction = 2;

                                              selected = 'transactions name';
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: ListTile(
                                            title:
                                                const Text('transactions name'),
                                            trailing: CircleAvatar(
                                                radius: 9.r,
                                                backgroundColor:
                                                    selectedTransaction == 2
                                                        ? AppColors
                                                            .kPrimaryColor2
                                                        : Colors.grey
                                                            .withOpacity(0.4)),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              selectedTransaction = 3;

                                              selected = 'transactions id';
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: ListTile(
                                            title:
                                                const Text('transactions id'),
                                            trailing: CircleAvatar(
                                                radius: 9.r,
                                                backgroundColor:
                                                    selectedTransaction == 3
                                                        ? AppColors
                                                            .kPrimaryColor2
                                                        : Colors.grey
                                                            .withOpacity(0.4)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 12.h),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(13.r),
                                border: Border.all(
                                  color: transactionDialoge
                                      ? AppColors.kPrimaryColor2
                                      : Colors.grey.withOpacity(0.4),
                                  width: 2,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 70.w,
                                    child: Text(
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      selected,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize:
                                            16.sp, // Adjust size as needed
                                      ),
                                    ),
                                  ),
                                  const Icon(FontAwesomeIcons.chevronDown),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            Expanded(
                              child: CustomTextField2(
                                  readOnly: false,
                                  hintText: 'Query to be excuted',
                                  controller: TextEditingController(),
                                  isNightModeEnabled: widget.isNightModeEnabled,
                                  icon: const SizedBox.shrink()),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Visibility(
              visible: showTransactions = showTransactions,
              child: Column(
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomButton(
                      color: AppColors.kPrimaryColor2,
                      buttonText: 'Search transactions',
                      width: double.infinity,
                      height: 37.h,
                      borderRadius: 10.r,
                      onTap: () {}),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Visibility(
              visible: showTransactions = showTransactions,
              child: Column(
                children: [
                  SizedBox(
                    height: 200.h,
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: 15.h),
                            child: const TransactionHistoryCard(),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 30.h,
            ),
          )
        ],
      ),
    );
  }
}
