import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/features/home%20screen/widgets/customstorywidget.dart';

class StoryList extends StatelessWidget {
  const StoryList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 98.h,
      child: ListView.builder(
        itemBuilder: (context, index) {
          return const CustomStoryWidget();
        },
        itemCount: 10,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
