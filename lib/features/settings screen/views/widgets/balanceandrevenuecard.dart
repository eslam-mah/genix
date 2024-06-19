import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BalanceAndRevenueCard extends StatelessWidget {
  const BalanceAndRevenueCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
                Text('CURRENT BALANCE', style: TextStyle(color: Colors.grey)),
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
                        '0',
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
                Text('REVENUE FROM SHORTS',
                    style: TextStyle(color: Colors.grey)),
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
                        '0',
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
                        'WITHDRAW',
                        style: TextStyle(color: Colors.white, fontSize: 10.sp),
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
  }
}
