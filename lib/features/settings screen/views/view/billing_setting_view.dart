import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/cubit/handler_cubit/handler_cubit.dart';
import 'package:genix/core/localization/all_app_strings.dart';
import 'package:genix/core/services/shared_preferences.dart';
import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/utils/pref_keys.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customheaderwidget2.dart';
import 'package:genix/core/widgets/customtextfield2.dart';
import 'package:genix/features/drawer/view%20model/theme_color_cubit/theme_cubit.dart';
import 'package:genix/features/payments/data/models/stripe_form.dart';
import 'package:genix/features/payments/view_model/create_stripe/create_stripe_cubit.dart';
import 'package:genix/features/settings%20screen/view%20model/get%20all%20transactions/get_all_transactions_cubit.dart';
import 'package:genix/features/settings%20screen/views/widgets/balance_and_revenue_card.dart';
import 'package:genix/features/settings%20screen/views/widgets/custom_billing_widget.dart';
import 'package:genix/features/settings%20screen/views/widgets/custom_billing_widget2.dart';
import 'package:genix/features/settings%20screen/views/widgets/transactions_list_view.dart';
import 'package:genix/features/splash%20screen/view%20model/first%20load/first_load_cubit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class BillingAreaSettings extends StatefulWidget {
  const BillingAreaSettings({
    super.key,
  });

  @override
  State<BillingAreaSettings> createState() => _BillingAreaSettingsState();
}

class _BillingAreaSettingsState extends State<BillingAreaSettings> {
  int isSelected = 0;
  num? selectedAmount;

  bool showTransactions = false;
  bool transactionDialog = false;
  int selectedTransaction = 0;
  bool isLoading = false;

  String selectedTransactionType = 'all transactions';
  String searchQuery = '';
  bool isNightModeEnabled = false;
  final TextEditingController queryController = TextEditingController();
  @override
  void initState() {
    super.initState();
    isNightModeEnabled = CacheData.getData(key: PrefKeys.kDarkMode) ?? false;
  }

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
    CacheData.setData(key: PrefKeys.kDarkMode, value: isNightMode);
  }

  void updateTransactionType(String type) {
    setState(() {
      selectedTransactionType = type;
      queryController.clear(); // Clear previous query when type changes
      searchQuery = ''; // Reset search query
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateStripeCubit, CreateStripeState>(
          listener: (context, state) {
            if (state is CreateStripeSuccess) {
              _displayPaymentSheet(context, state.clientSecret);
              print('_________________________________//${state.clientSecret}');
            } else if (state is CreateStripeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.error}')),
              );
            }
          },
        ),
        BlocListener<ThemeCubit, ThemeState>(
          listener: (context, state) {
            final isNightMode = state == ThemeState.dark;
            handleNightModeChanged(isNightMode);
          },
        ),
      ],
      child: RefreshIndicator(
        color: AppColors.kPrimaryColor,
        onRefresh: () {
          return context.read<FirstLoadCubit>().firstLoad();
        },
        child: ModalProgressHUD(
          inAsyncCall: isLoading,
          progressIndicator: const CircularProgressIndicator(
            color: AppColors.kPrimaryColor,
          ),
          child: Padding(
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
                       CustomHeaderWidget2(text: AppStrings.billingarea.getString(context)),
                      SizedBox(
                        height: 20.h,
                      ),
                      Text(AppStrings.billingareacap.getString(context), style: TextStyle(fontSize: 13.sp)),
                      Text(AppStrings.browsetransactionsandaddmorecoinstoyouraccount.getString(context),
                          style: TextStyle(fontSize: 10.sp)),
                      SizedBox(
                        height: 10.h,
                      ),
                      const BalanceAndRevenueCard(),
                      SizedBox(
                        height: 10.h,
                      ),
                      Text(AppStrings.topup.getString(context),
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
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
                                selectedAmount = isSelected == 1 ? 10.0 : null;
                                FocusScope.of(context).unfocus();
                              });
                            },
                            child: CustomBillingWidget(
                                isSelected: isSelected,
                                numberSelected: 1,
                                amount: 10,
                                isNightModeEnabled:
                                    ThemeCubit().state == ThemeState.dark),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isSelected = isSelected == 2 ? 0 : 2;
                                selectedAmount = isSelected == 2 ? 50.0 : null;
                                FocusScope.of(context).unfocus();
                              });
                            },
                            child: CustomBillingWidget(
                                isSelected: isSelected,
                                numberSelected: 2,
                                amount: 50,
                                isNightModeEnabled:
                                    ThemeCubit().state == ThemeState.dark),
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
                                selectedAmount =
                                    isSelected == 3 ? 1500.0 : null;
                                FocusScope.of(context).unfocus();
                              });
                            },
                            child: CustomBillingWidget(
                                isSelected: isSelected,
                                numberSelected: 3,
                                amount: 1500,
                                isNightModeEnabled:
                                    ThemeCubit().state == ThemeState.dark),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isSelected = isSelected == 4 ? 0 : 4;
                                selectedAmount =
                                    isSelected == 4 ? 3500.0 : null;
                                FocusScope.of(context).unfocus();
                              });
                            },
                            child: CustomBillingWidget(
                                isSelected: isSelected,
                                numberSelected: 4,
                                amount: 3500,
                                isNightModeEnabled:
                                    ThemeCubit().state == ThemeState.dark),
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
                                selectedAmount =
                                    isSelected == 5 ? 7000.0 : null;
                                FocusScope.of(context).unfocus();
                              });
                            },
                            child: CustomBillingWidget(
                                isSelected: isSelected,
                                numberSelected: 5,
                                amount: 7000,
                                isNightModeEnabled:
                                    ThemeCubit().state == ThemeState.dark),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                isSelected = isSelected == 6 ? 0 : 6;
                                selectedAmount =
                                    isSelected == 6 ? 10000.0 : null;
                                FocusScope.of(context).unfocus();
                              });
                            },
                            child: CustomBillingWidget(
                                isSelected: isSelected,
                                numberSelected: 6,
                                amount: 10000,
                                isNightModeEnabled:
                                    ThemeCubit().state == ThemeState.dark),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomBillingWidget2(
                        isSelected: isSelected,
                        numberSelected: 7,
                        isNightModeEnabled:
                            ThemeCubit().state == ThemeState.dark,
                        onAmountChanged: (int amount) {
                          isSelected = isSelected == 7 ? 0 : 7;
                          selectedAmount = amount;
                        },
                      )
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
                          buttonText:AppStrings.gotopayment.getString(context),
                          width: double.infinity,
                          height: 35.h,
                          borderRadius: 10.r,
                          onTap: () async {
                            Future<void> _displayPaymentSheet(
                                BuildContext context,
                                String clientSecret) async {
                              try {
                                // Initialize payment sheet with client secret
                                await Stripe.instance.initPaymentSheet(
                                  paymentSheetParameters:
                                      SetupPaymentSheetParameters(
                                    paymentIntentClientSecret: clientSecret,
                                    merchantDisplayName: 'Genix',
                                  ),
                                );

                                // Display payment sheet
                                await Stripe.instance.presentPaymentSheet();

                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                      content: Text(AppStrings.paymentcompletedsuccessfully.getString(context))),
                                );
                              } catch (e) {
                                // ignore: use_build_context_synchronously
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(AppStrings.paymentfailed.getString(context))),
                                );
                              }
                            }

                            setState(() {
                              isLoading = true;
                            });
                            if (selectedAmount != null) {
                              await context
                                  .read<CreateStripeCubit>()
                                  .createStripe(
                                      data:
                                          StripeForm(amount: selectedAmount!));

                              setState(() {
                                isLoading = false;
                              });
                              print(selectedAmount);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(
                                    content: Text(AppStrings.pleaseselectanamount.getString(context))),
                              );
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }),
                      SizedBox(
                        height: 10.h,
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        showTransactions = !showTransactions;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
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
                            AppStrings.showlatesttransactionscap.getString(context),
                            style: TextStyle(
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
                    visible: showTransactions,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.transactionscap.getString(context),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          ),
                        ),
                        Text(
                          AppStrings.transactionnote.getString(context),
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        SizedBox(height: 10.h),
                        InkWell(
                          onTap: () {
                            setState(() {
                              transactionDialog = !transactionDialog;
                            });
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        Text(
                                          AppStrings.searchtransactionsby.getString(context),
                                          style: TextStyle(fontSize: 20.sp),
                                        ),
                                        Divider(
                                            color:
                                                Colors.black.withOpacity(0.1)),
                                        ListTile(
                                          title:  Text(AppStrings.alltransactions.getString(context)),
                                          trailing: _buildRadioCircle(1),
                                          onTap: () {
                                            updateTransactionType(
                                                'all transactions');
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        ListTile(
                                          title:
                                               Text(AppStrings.transactionname.getString(context)),
                                          trailing: _buildRadioCircle(2),
                                          onTap: () {
                                            updateTransactionType(
                                                'transactions name');
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        ListTile(
                                          title:  Text(AppStrings.transactionid.getString(context)),
                                          trailing: _buildRadioCircle(3),
                                          onTap: () {
                                            updateTransactionType(
                                                'transactions id');
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: _buildTransactionSelectionRow(),
                        ),
                        SizedBox(height: 10.h),
                        CustomButton(
                          color: AppColors.kPrimaryColor2,
                          buttonText: AppStrings.searchtransactions.getString(context),
                          width: double.infinity,
                          height: 37.h,
                          borderRadius: 10.r,
                          onTap: () {
                            setState(() {
                              searchQuery = queryController.text.trim();
                            });
                          },
                        ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Visibility(
                    visible: showTransactions = showTransactions,
                    child: TransactionsListView(
                      isNightModeEnabled: isNightModeEnabled,
                      searchType: selectedTransactionType,
                      query: searchQuery,
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
          ),
        ),
      ),
    );
  }

  CircleAvatar _buildRadioCircle(int index) {
    return CircleAvatar(
      radius: 9.r,
      backgroundColor: selectedTransaction == index
          ? AppColors.kPrimaryColor2
          : Colors.grey.withOpacity(0.4),
    );
  }

  Row _buildTransactionSelectionRow() {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(13.r),
            border: Border.all(
              color: transactionDialog
                  ? AppColors.kPrimaryColor2
                  : Colors.grey.withOpacity(0.4),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: 70.w,
                child: Text(
                  selectedTransactionType,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 16.sp),
                ),
              ),
              const Icon(FontAwesomeIcons.chevronDown),
            ],
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: CustomTextField2(
            readOnly: false,
            hintText: AppStrings.querytobeexecuted.getString(context),
            controller: queryController,
            icon: const SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  Future<void> _displayPaymentSheet(
      BuildContext context, String clientSecret) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Genix',
        ),
      );
      await Stripe.instance.presentPaymentSheet();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(AppStrings.paymentcompletedsuccessfully.getString(context))),
      );
      // ignore: use_build_context_synchronously
      context.read<FirstLoadCubit>().firstLoad();
    } catch (e) {
      print(e);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${AppStrings.paymentfailed.getString(context)}:' '$e')),
      );
    }
  }
}
