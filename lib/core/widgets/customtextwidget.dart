import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    super.key,
    required this.textSize,
    required this.fontFamily,
    required this.fontWeight,
    required this.color,
    required this.text,
  });
  final String text;
  final double textSize;
  final String fontFamily;
  final FontWeight fontWeight;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontSize: textSize,
          fontWeight: fontWeight,
          color: color,
          fontFamily: fontFamily),
    );
  }
}
