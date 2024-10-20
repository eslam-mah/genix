import 'package:flutter/material.dart';

class CustomAppBarIcon extends StatelessWidget {
  const CustomAppBarIcon(
      {super.key,
      required this.icon,
      this.color,
      this.onTap,
      required this.size});
  final IconData icon;
  final Color? color;
  final Function()? onTap;
  final double size;
  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: onTap,
        icon: Icon(
          icon,
          size: size,
          color: color,
        ));
  }
}
