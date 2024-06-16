import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.readOnly,
    required this.onTap,
    required this.controller,
    required this.isObscure,
  });
  final String hintText;
  final bool readOnly;
  final Function() onTap;
  final TextEditingController controller;
  final bool isObscure;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: TextFormField(
        obscureText: isObscure,
        controller: controller,
        onTap: onTap,
        readOnly: readOnly,
        decoration: InputDecoration(hintText: hintText),
      ),
    );
  }
}
