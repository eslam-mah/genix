import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomImageIcon extends StatelessWidget {
  const CustomImageIcon({
    super.key,
    required this.image,
    required this.text,
    required this.onTap,
    required this.duration,
  });
  final String image;
  final String text;
  final Function() onTap;
  final int duration;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      child: Animate(
        effects: [
          SlideEffect(
              duration: Duration(milliseconds: duration),
              curve: Curves.fastLinearToSlowEaseIn),
          FadeEffect(
              duration: Duration(milliseconds: duration), curve: Curves.easeIn)
        ],
        child: InkWell(
          onTap: onTap,
          child: Column(
            children: [
              Image.asset(image),
              Text(text, textAlign: TextAlign.center
                  // textScaler: TextScaler.linear(0.7),
                  )
            ],
          ),
        ),
      ),
    );
  }
}
