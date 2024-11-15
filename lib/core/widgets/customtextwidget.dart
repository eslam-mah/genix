import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  const CustomTextWidget({
    super.key,
    required this.textSize,
    required this.fontFamily,
    required this.fontWeight,
    this.color,
    required this.text,
    this.maxLines,
    this.width,
  });
  final String text;
  final double textSize;
  final String fontFamily;
  final FontWeight fontWeight;
  final Color? color;
  final int? maxLines;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Text(
        maxLines: maxLines,
        text,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
            fontSize: textSize,
            fontWeight: fontWeight,
            color: color,
            fontFamily: fontFamily),
      ),
    );
  }
}
