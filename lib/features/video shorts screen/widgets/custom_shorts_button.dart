import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomShortsButton extends StatelessWidget {
  const CustomShortsButton({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    required this.onTap,
  });
  final IconData icon;
  final String text;
  final Color color;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
            onPressed: onTap,
            icon: Icon(
              icon,
              color: color,
              size: 30.r,
            )),
        Text(
          text,
          style: TextStyle(color: Colors.white),
        )
      ],
    );
  }
}
