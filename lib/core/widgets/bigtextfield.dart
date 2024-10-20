import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:genix/core/utils/colors.dart';

class BigTextField extends StatelessWidget {
  const BigTextField({
    super.key,
    required this.hintText,
    this.color,
    required this.controller,
  });
  final String hintText;
  final Color? color;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
      ),
      height: 120.h,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          TextField(
            controller: controller,
            expands: true,
            maxLines: null,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: const BorderSide(color: AppColors.kPrimaryColor)),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: const BorderSide(color: AppColors.kPrimaryColor)),
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 48, 12),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: const BorderSide(color: AppColors.kPrimaryColor)),
            ),
            textAlignVertical: TextAlignVertical.top,
          ),
        ],
      ),
    );
  }
}
