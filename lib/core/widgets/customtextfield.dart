import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.readOnly,
    required this.onTap,
    required this.controller,
  });
  final String hintText;
  final bool readOnly;
  final Function() onTap;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: TextField(
        controller: controller,
        onTap: onTap,
        readOnly: readOnly,
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }
}
