import 'package:flutter/material.dart';
import 'package:genix/core/utils/colors.dart';

class FirstPageProgressIndicator extends StatelessWidget {
  const FirstPageProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) => const Center(
        child: CircularProgressIndicator(
          color: AppColors.kPrimaryColor,
        ),
      );
}
