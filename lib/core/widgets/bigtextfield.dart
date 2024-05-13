import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:genix/core/utils/colors.dart';

class BigTextField extends StatelessWidget {
  const BigTextField({
    super.key,
    required this.hintText,
    required this.color,
  });
  final String hintText;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20.r),
      ),
      height: 120.h,
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          TextField(
            expands: true,
            maxLines: null,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.black.withOpacity(0.2)),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.2))),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(color: Colors.black.withOpacity(0.2))),
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 48, 12),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide:
                      const BorderSide(color: AppColors.kPrimaryColor2)),
            ),
            textAlignVertical: TextAlignVertical.top,
          ),
        ],
      ),
    );
  }
}
