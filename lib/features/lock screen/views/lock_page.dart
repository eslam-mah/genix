import 'package:flutter/material.dart';

class LockPageArgs {
  const LockPageArgs();
}

class LockPage extends StatelessWidget {
  const LockPage({super.key, required this.args});
  static const String route = '/lock';
  final LockPageArgs args;
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
