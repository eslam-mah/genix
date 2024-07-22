import 'package:flutter/material.dart';
import 'package:genix/core/utils/colors.dart';

class FirstPageProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
        child: CircularProgressIndicator(
          color: AppColors.kPrimaryColor,
        ),
      );
}
