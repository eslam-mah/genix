import 'package:flutter/material.dart';

import 'package:genix/core/utils/colors.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: 0,
            top: 0,
            bottom: 0,
            child: SafeArea(
              child: Container(
                width: 240,
                height: double.infinity,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      offset: const Offset(-1, 5),
                      spreadRadius: 7,
                      blurRadius: 0.5,
                      color: Colors.black.withOpacity(0.1))
                ], color: AppColors.kAppBar2Color),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
