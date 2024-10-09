import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/utils/colors.dart';

class CustomTextField2 extends StatefulWidget {
  const CustomTextField2({
    super.key,
    required this.readOnly,
    required this.hintText,
    required this.controller,
    required this.icon,
  });
  final bool readOnly;
  final String hintText;
  final TextEditingController controller;
  final Widget icon;
  @override
  State<CustomTextField2> createState() => _CustomTextField2State();
}

class _CustomTextField2State extends State<CustomTextField2> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: widget.readOnly,
      controller: widget.controller,
      decoration: InputDecoration(
          suffixIcon: widget.icon,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13.r),
              borderSide: const BorderSide(
                width: 2,
                style: BorderStyle.solid,
                color: AppColors.kPrimaryColor2,
              )),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13.r),
            borderSide: const BorderSide(color: AppColors.kPrimaryColor),
          ),
          hintText: widget.hintText,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.green))),
    );
  }
}
