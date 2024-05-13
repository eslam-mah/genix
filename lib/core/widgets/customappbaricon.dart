import 'package:flutter/material.dart';

class CustomAppBarIcon extends StatelessWidget {
  const CustomAppBarIcon(
      {super.key,
      required this.icon,
      required this.color,
      required this.onTap,
      required this.size});
  final IconData icon;
  final Color color;
  final Function() onTap;
  final double size;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Icon(
          icon,
          color: color,
          size: size,
        ));
  }
}
