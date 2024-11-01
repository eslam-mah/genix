import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:genix/core/widgets/custom_small_user_profile_image.dart';
import 'package:genix/core/widgets/customtextwidget.dart';
import 'package:genix/core/widgets/custom_user_profile_image.dart';
import 'package:genix/features/support%20tickets%20screen/data/models/tickets_model.dart';
import 'package:intl/intl.dart';

class CustomTicketsItem extends StatelessWidget {
  const CustomTicketsItem({
    super.key,
    required this.ticket,
  });
  final TicketsModel ticket;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 6.h),
      child: Container(
          color: Colors.grey.withOpacity(0.2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomUserProfileImage(
                showname: ticket.user.showname,
                image: ticket.user.profileImg,
                isActive: ticket.user.isActive,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        ticket.status == 'closed'
                            ? FontAwesomeIcons.lock
                            : FontAwesomeIcons.lockOpen,
                        size: 12.r,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      SizedBox(
                        width: 170.w,
                        child: CustomTextWidget(
                          textSize: 12.sp,
                          fontFamily: '',
                          fontWeight: FontWeight.w400,
                          text: ticket.title,
                        ),
                      )
                    ],
                  ),
                  CustomTextWidget(
                    textSize: 12.sp,
                    fontFamily: '',
                    fontWeight: FontWeight.w400,
                    text:
                        'Created on ${DateFormat('MMMM d, yyyy').format(ticket.createdAt)}',
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextWidget(
                    textSize: 12.sp,
                    fontFamily: '',
                    fontWeight: FontWeight.w400,
                    text: 'Last reply by',
                  ),
                  Row(
                    children: [
                      CustomSmallUserProfileImage(
                        textPlaceHolder: Text(
                          ticket.lastUser.showname
                              .split('')
                              .take(2)
                              .join()
                              .toUpperCase(),
                          style:
                              TextStyle(fontSize: 10.sp, color: Colors.white),
                        ),
                        image: ticket.lastUser.profileImg,
                        isActive: ticket.lastUser.isActive,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                      SizedBox(
                        width: 40.w,
                        child: CustomTextWidget(
                          textSize: 12.sp,
                          fontFamily: '',
                          fontWeight: FontWeight.w400,
                          text: ticket.lastUser.showname,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          )),
    );
  }
}
