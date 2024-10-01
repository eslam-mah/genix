import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/utils/colors.dart';

import 'package:genix/core/widgets/customappbar.dart';
import 'package:genix/core/widgets/custombottomappbar.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/core/widgets/customuserprofileimage.dart';
import 'package:genix/features/drawer/view/custom_drawer_widget.dart';
import 'package:genix/core/widgets/customglowingbutton.dart';
import 'package:genix/core/widgets/customheaderwidget.dart';

import 'package:genix/core/widgets/glowingbuttonbody.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/tickets_model.dart';
import 'package:intl/intl.dart';

class TicketItemPage extends StatefulWidget {
  const TicketItemPage({super.key, required this.ticket});
  static const route = '/ticketItemPage';
  final TicketsModel ticket;
  @override
  State<TicketItemPage> createState() => _TicketItemPageState();
}

class _TicketItemPageState extends State<TicketItemPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelected = false;
  bool isNightModeEnabled = false;

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            CustomBottomAppBar(
              isNightMode: isNightModeEnabled,
            ),
            Positioned(
              bottom: 20,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected = !isSelected;
                  });
                },
                child: CustomGlowingButton(isSelected: isSelected),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              FontAwesomeIcons.barsStaggered,
              size: 18.sp,
            ), // Custom icon
            onPressed: () {
              _scaffoldKey.currentState?.openEndDrawer(); // Open the drawer
            },
          ),
        ],
        elevation: 0,
        title: const CustomAppBar(),
      ),
      endDrawer: CustomDrawerWidget(
        isNightMode: isNightModeEnabled,
      ),
      body: isSelected
          ? const GlowingButtonBody()
          : CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(
                  child: CustomHeaderWidget(text: 'Support tickets'),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(10.w),
                    child: Column(
                      children: [
                        Container(
                          height: 140.h,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400)),
                          child: Padding(
                            padding: EdgeInsets.all(13.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextWidget(
                                      textSize: 18.sp,
                                      fontFamily: '',
                                      fontWeight: FontWeight.normal,
                                      text: 'Ticket summary',
                                      isNightMode: isNightModeEnabled,
                                    ),
                                    CustomTextWidget(
                                      textSize: 18.sp,
                                      fontFamily: '',
                                      fontWeight: FontWeight.normal,
                                      text: 'Available actions',
                                      isNightMode: isNightModeEnabled,
                                    )
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        _TextRow(
                                          titleText: 'Title',
                                          theText: widget.ticket.title,
                                          isGreen: false,
                                          isNightMode: isNightModeEnabled,
                                        ),
                                        _TextRow(
                                          titleText: 'Created at',
                                          theText: DateFormat('MMMM d, yyyy')
                                              .format(widget.ticket.createdAt),
                                          isGreen: false,
                                          isNightMode: isNightModeEnabled,
                                        ),
                                        _TextRow(
                                          titleText: 'Last Reply by',
                                          theText:
                                              widget.ticket.lastUser.showname,
                                          isGreen: true,
                                          isNightMode: isNightModeEnabled,
                                        ),
                                        _TextRow(
                                          titleText: 'Replies in total',
                                          theText: '0',
                                          isGreen: false,
                                          isNightMode: isNightModeEnabled,
                                        ),
                                        _TextRow(
                                          titleText: 'Status',
                                          theText: widget.ticket.status,
                                          isGreen: true,
                                          isNightMode: isNightModeEnabled,
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomButton(
                                            color: AppColors.kPrimaryColor,
                                            buttonText: 'Close Ticket',
                                            width: 100.w,
                                            height: 27.h,
                                            borderRadius: 10.r,
                                            onTap: () {}),
                                        SizedBox(
                                          height: 6.h,
                                        ),
                                        CustomButton(
                                            color: AppColors.kPrimaryColor,
                                            buttonText: 'Edit Ticket',
                                            width: 100.w,
                                            height: 27.h,
                                            borderRadius: 10.r,
                                            onTap: () {})
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CustomButton(
                            icon: Icon(
                              FontAwesomeIcons.pencil,
                              color: Colors.white,
                              size: 20.r,
                            ),
                            color: AppColors.kPrimaryColor,
                            buttonText: 'Post a reply',
                            height: 40.h,
                            borderRadius: 15.r,
                            onTap: () {}),
                        SizedBox(
                          height: 20.h,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400)),
                          child: Padding(
                            padding: EdgeInsets.all(5.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomUserProfileImage(
                                        image: widget.ticket.user.profileImg,
                                        isActive: widget.ticket.user.isActive),
                                    SizedBox(
                                      width: 10.w,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTextWidget(
                                          textSize: 13.sp,
                                          fontFamily: '',
                                          fontWeight: FontWeight.normal,
                                          color: Colors.green,
                                          text: widget.ticket.user.showname,
                                          isNightMode: isNightModeEnabled,
                                        ),
                                        CustomTextWidget(
                                          textSize: 13.sp,
                                          fontFamily: '',
                                          fontWeight: FontWeight.normal,
                                          text:
                                              'wrote on ${DateFormat('MMMM d, yyyy').format(widget.ticket.createdAt)}',
                                          isNightMode: isNightModeEnabled,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                CustomTextWidget(
                                  maxLines: 1000,
                                  textSize: 13.sp,
                                  fontFamily: '',
                                  fontWeight: FontWeight.normal,
                                  text: widget.ticket.content,
                                  isNightMode: isNightModeEnabled,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }
}

class _TextRow extends StatelessWidget {
  const _TextRow({
    super.key,
    required this.titleText,
    required this.theText,
    required this.isGreen,
    required this.isNightMode,
  });
  final String titleText;
  final String theText;
  final bool isGreen;
  final bool isNightMode;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomTextWidget(
          textSize: 13.sp,
          fontFamily: '',
          fontWeight: FontWeight.normal,
          text: titleText + ': ',
          isNightMode: isNightMode,
        ),
        SizedBox(
          width: 100.w,
          child: CustomTextWidget(
            textSize: 13.sp,
            fontFamily: '',
            fontWeight: FontWeight.normal,
            color: isGreen ? Colors.green : Colors.grey.shade500,
            text: theText,
            isNightMode: isNightMode,
          ),
        )
      ],
    );
  }
}
