import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:genix/core/localization/all_app_strings.dart';

class FirstPageErrorIndicator extends StatelessWidget {
  const FirstPageErrorIndicator({
    this.onTryAgain,
    super.key,
  });

  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) =>  Text('${AppStrings.somethingwentwrong.getString(context)}');
}
