// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/ticket_model.dart';
import 'package:genix/features/support%20tickets%20screen/view%20model/get%20tickets%20by%20id/get_tickets_by_id_cubit.dart';
import 'package:genix/features/support%20tickets%20screen/view%20model/post%20ticket%20comment/post_ticket_comment_cubit.dart';
import 'package:genix/features/support%20tickets%20screen/views/widgets/post_reply_bottom_sheet.dart';
import 'package:genix/features/support%20tickets%20screen/views/widgets/ticket_reply_item.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';

import 'package:genix/core/utils/colors.dart';
import 'package:genix/core/widgets/custom_user_profile_image.dart';
import 'package:genix/core/widgets/customappbar.dart';
import 'package:genix/core/widgets/custombottomappbar.dart';
import 'package:genix/core/widgets/custombutton.dart';
import 'package:genix/core/widgets/customglowingbutton.dart';
import 'package:genix/core/widgets/customheaderwidget.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/core/widgets/glowing_button_body.dart';
import 'package:genix/features/drawer/view/custom_drawer_widget.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/tickets_model.dart';
import 'package:genix/features/support%20tickets%20screen/view%20model/update%20ticket%20status/update_ticket_status_cubit.dart';
import 'package:genix/features/support%20tickets%20screen/views/widgets/edit_ticket_bottom_sheet.dart';

class TicketItemPage extends StatefulWidget {
  const TicketItemPage(
      {super.key, required this.refresh, required this.ticket});
  static const route = '/ticketItemPage';
  final TicketsModel ticket;
  final Function() refresh;
  @override
  State<TicketItemPage> createState() => _TicketItemPageState();
}

class _TicketItemPageState extends State<TicketItemPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isSelected = false;
  bool isNightModeEnabled = false;
  late ValueNotifier<bool> isClosedNotifier;
  @override
  void initState() {
    super.initState();
    context.read<GetTicketsByIdCubit>().getTicketById(id: widget.ticket.id);
    isClosedNotifier = ValueNotifier(
      widget.ticket.status == 'closed',
    );
  }

  @override
  void dispose() {
    isClosedNotifier.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() async {
    await context
        .read<GetTicketsByIdCubit>()
        .getTicketById(id: widget.ticket.id);
  }

  void handleNightModeChanged(bool isNightMode) {
    setState(() {
      isNightModeEnabled = isNightMode;
    });
  }

  String _removeHtmlTags(String htmlString) {
    final document = parse(htmlString);
    return document.body?.text ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PostTicketCommentCubit, PostTicketCommentState>(
          listener: (context, state) {
            if (state is PostTicketCommentSuccess) {
              _onRefresh();
            }
          },
        ),
      ],
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: SafeArea(
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              const CustomBottomAppBar(),
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
          toolbarHeight: 45.h,
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
            : RefreshIndicator(
                onRefresh: _onRefresh,
                color: AppColors.kPrimaryColor,
                child: BlocBuilder<GetTicketsByIdCubit, GetTicketsByIdState>(
                  builder: (context, state) {
                    if (state is GetTicketsByIdSuccess) {
                      return CustomScrollView(
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
                                        border: Border.all(
                                            color: Colors.grey.shade400)),
                                    child: Padding(
                                      padding: EdgeInsets.all(13.w),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
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
                                              ),
                                              CustomTextWidget(
                                                textSize: 18.sp,
                                                fontFamily: '',
                                                fontWeight: FontWeight.normal,
                                                text: 'Available actions',
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
                                                    theText: state.tickets.data
                                                            ?.title ??
                                                        '',
                                                    isGreen: false,
                                                  ),
                                                  _TextRow(
                                                    titleText: 'Created at',
                                                    theText: DateFormat(
                                                            'MMMM d, yyyy')
                                                        .format(state
                                                                .tickets
                                                                .data
                                                                ?.createdAt ??
                                                            DateTime.now()),
                                                    isGreen: false,
                                                  ),
                                                  _TextRow(
                                                    titleText: 'Last Reply by',
                                                    theText: widget.ticket
                                                        .lastUser.showname,
                                                    isGreen: true,
                                                  ),
                                                  _TextRow(
                                                    titleText:
                                                        'Replies in total',
                                                    theText: state.tickets.data
                                                            ?.comments?.length
                                                            .toString() ??
                                                        0.toString(),
                                                    isGreen: false,
                                                  ),
                                                  ValueListenableBuilder<bool>(
                                                      valueListenable:
                                                          isClosedNotifier,
                                                      builder: (context,
                                                          isClosed, _) {
                                                        return _TextRow(
                                                          titleText: 'Status',
                                                          theText: state
                                                                          .tickets
                                                                          .data
                                                                          ?.status ==
                                                                      'open' &&
                                                                  !isClosed
                                                              ? 'Open'
                                                              : 'Closed',
                                                          isGreen: true,
                                                          isClosedNotifier:
                                                              isClosedNotifier,
                                                        );
                                                      })
                                                ],
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  _CloseTicketButton(
                                                    ticket: widget.ticket,
                                                    isClosedNotifier:
                                                        isClosedNotifier,
                                                    refresh: () {
                                                      widget.refresh();
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 6.h,
                                                  ),
                                                  CustomButton(
                                                      color: AppColors
                                                          .kPrimaryColor,
                                                      buttonText: 'Edit Ticket',
                                                      width: 100.w,
                                                      height: 27.h,
                                                      borderRadius: 10.r,
                                                      onTap: () {
                                                        editTicketBottomSheet(
                                                            context,
                                                            refresh: () {
                                                          widget.refresh();
                                                        },
                                                            ticket:
                                                                state.tickets);
                                                      })
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
                                  ValueListenableBuilder<bool>(
                                    valueListenable:
                                        isClosedNotifier, // Listen to the isClosedNotifier
                                    builder: (context, isClosed, _) {
                                      // If the ticket is not closed, show the button; otherwise, don't show anything.
                                      if (!isClosed) {
                                        return Column(
                                          children: [
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
                                                onTap: () {
                                                  postReplyBottomSheet(context,
                                                      () {
                                                    _onRefresh();
                                                  },
                                                      state.tickets.data?.id ??
                                                          0);
                                                }),
                                            SizedBox(
                                              height: 20.h,
                                            ),
                                          ],
                                        );
                                      }
                                      // If the ticket is closed, return an empty container
                                      return const SizedBox.shrink();
                                    },
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.grey.shade400)),
                                    child: Padding(
                                      padding: EdgeInsets.all(5.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CustomUserProfileImage(
                                                showname: state.tickets.data
                                                        ?.user?.showname ??
                                                    '',
                                                image: state.tickets.data?.user
                                                        ?.profileImg ??
                                                    '',
                                                isActive: state.tickets.data
                                                        ?.user?.isActive ??
                                                    false,
                                              ),
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
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.green,
                                                    text: state.tickets.data
                                                            ?.user?.showname ??
                                                        '',
                                                  ),
                                                  CustomTextWidget(
                                                    textSize: 13.sp,
                                                    fontFamily: '',
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    text:
                                                        'wrote on //${DateFormat('MMMM d, yyyy').format(state.tickets.data?.createdAt ?? DateTime.now())}',
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
                                            text: _removeHtmlTags(
                                                widget.ticket.content),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          state.tickets.data?.comments?.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 10.h),
                                          child: ReplyItem(
                                            comment: state.tickets.data
                                                    ?.comments?[index] ??
                                                Comment(),
                                            refresh: () {
                                              _onRefresh();
                                            },
                                          ),
                                        );
                                      }),
                                ],
                              ),
                            ),
                          )
                        ],
                      );
                    } else {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: AppColors.kPrimaryColor,
                      ));
                    }
                  },
                ),
              ),
      ),
    );
  }
}

class _CloseTicketButton extends StatefulWidget {
  final TicketsModel ticket;
  ValueNotifier<bool> isClosedNotifier;
  final Function() refresh;
  _CloseTicketButton({
    super.key,
    required this.ticket,
    required this.isClosedNotifier,
    required this.refresh,
  });

  @override
  State<_CloseTicketButton> createState() => _CloseTicketButtonState();
}

class _CloseTicketButtonState extends State<_CloseTicketButton> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: widget.isClosedNotifier,
        builder: (context, isClosed, _) {
          return isClosed
              ? CustomButton(
                  color: AppColors.kPrimaryColor,
                  buttonText: 'Reopen Ticket',
                  width: 100.w,
                  height: 27.h,
                  borderRadius: 10.r,
                  onTap: () {
                    context.read<UpdateTicketStatusCubit>().updateTicket(
                        data: {}, ticketId: widget.ticket.id, status: 'open');
                    widget.isClosedNotifier.value = false;
                    widget.refresh();
                  })
              : CustomButton(
                  color: AppColors.kPrimaryColor,
                  buttonText: 'Close Ticket',
                  width: 100.w,
                  height: 27.h,
                  borderRadius: 10.r,
                  onTap: () {
                    context.read<UpdateTicketStatusCubit>().updateTicket(
                        data: {}, ticketId: widget.ticket.id, status: 'closed');
                    widget.isClosedNotifier.value = true;
                    widget.refresh();
                  });
        });
  }
}

class _TextRow extends StatelessWidget {
  _TextRow({
    Key? key,
    required this.titleText,
    required this.theText,
    required this.isGreen,
    this.isClosedNotifier,
  }) : super(key: key);
  final String titleText;
  final String theText;
  final bool isGreen;
  ValueNotifier<bool>? isClosedNotifier;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomTextWidget(
          textSize: 13.sp,
          fontFamily: '',
          fontWeight: FontWeight.normal,
          text: titleText + ': ',
        ),
        SizedBox(
          width: 100.w,
          child: ValueListenableBuilder<bool>(
              valueListenable: isClosedNotifier ?? ValueNotifier(false),
              builder: (context, isClosed, _) {
                return CustomTextWidget(
                  textSize: 13.sp,
                  fontFamily: '',
                  fontWeight: FontWeight.normal,
                  color: isGreen
                      ? isClosed
                          ? Colors.red
                          : Colors.green
                      : Colors.grey.shade500,
                  text: theText,
                );
              }),
        )
      ],
    );
  }
}
