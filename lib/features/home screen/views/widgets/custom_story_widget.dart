import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:genix/core/utils/images.dart';

class CustomStoryWidget extends StatelessWidget {
  const CustomStoryWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: GestureDetector(
        onTap: () {
          //  Navigator.of(context).push(CustomTransition(MessageScreenBody()));
        },
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundColor: const Color.fromARGB(255, 14, 215, 21),
                  radius: 30.r,
                ),
                Positioned(
                    left: 3,
                    bottom: 3,
                    child: CircleAvatar(
                      radius: 27.r,
                      child: Image.asset(AppImages.kMyProfile),
                    ))
              ],
            ),
            const Text('userr')
          ],
        ),
      ),
    );
  }
}
