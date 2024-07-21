import 'package:flutter/material.dart';

class FirstPageErrorIndicator extends StatelessWidget {
  const FirstPageErrorIndicator({
    this.onTryAgain,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) => Text('Something went wrong');
  // FirstPageExceptionIndicator(
  //       title: 'Something went wrong',
  //       message: 'The application has encountered an unknown error.\n'
  //           'Please try again later.',
  //       onTryAgain: onTryAgain,
  //     );
}
