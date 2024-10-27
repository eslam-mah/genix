import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class ShortAppBarItems extends StatelessWidget {
  const ShortAppBarItems({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40.r,
          height: 40.r,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.6),
            shape: BoxShape.circle,
          ),
          child: IconButton(
              onPressed: () {
                GoRouter.of(context).pop();
              },
              icon: Icon(
                FontAwesomeIcons.chevronLeft,
                color: Colors.white,
                size: 18.sp,
              )),
        ),
        SizedBox(
          width: 155.w,
        ),
        Container(
          width: 40.r,
          height: 40.r,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.6),
            shape: BoxShape.circle,
          ),
          child: IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.magnifyingGlass,
                color: Colors.white,
                size: 18.sp,
              )),
        ),
        SizedBox(
          width: 10.w,
        ),
        Container(
          width: 40.r,
          height: 40.r,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.6),
            shape: BoxShape.circle,
          ),
          child: IconButton(
              onPressed: () {},
              icon: Icon(
                FontAwesomeIcons.ellipsisVertical,
                color: Colors.white,
                size: 18.sp,
              )),
        ),
      ],
    );
  }
}
