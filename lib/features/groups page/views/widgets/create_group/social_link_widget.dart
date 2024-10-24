import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:genix/core/widgets/customtextfield2.dart';

class SocialLinksWidget extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  const SocialLinksWidget({
    super.key,
    required this.icon,
    required this.hintText,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 27.r,
        ),
        SizedBox(
          width: 15.w,
        ),
        Expanded(
            child: CustomTextField2(
                readOnly: false,
                hintText: hintText,
                controller: controller,
                icon: const SizedBox.shrink()))
      ],
    );
  }
}
