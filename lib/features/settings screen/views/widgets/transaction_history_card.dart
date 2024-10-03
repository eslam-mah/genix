import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TransactionHistoryCard extends StatelessWidget {
  const TransactionHistoryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
                '#38'),
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
              'Stripe(10 coins for 0.1 eur)',
              style: TextStyle(fontSize: 12.sp),
            ),
            Text(
                style: TextStyle(
                  fontSize: 11.sp,
                ),
                'march 30'),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'STATU',
              style: TextStyle(fontSize: 12.sp),
            ),
            Text(
                style: TextStyle(fontSize: 12.sp, color: Colors.blue),
                'initiat'),
          ],
        )
      ],
    );
  }
}
