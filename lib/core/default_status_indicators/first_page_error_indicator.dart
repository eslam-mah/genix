import 'package:flutter/material.dart';

class FirstPageErrorIndicator extends StatelessWidget {
  const FirstPageErrorIndicator({
    this.onTryAgain,
    super.key,
  });

  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) => const Text('Something went wrong');
}
