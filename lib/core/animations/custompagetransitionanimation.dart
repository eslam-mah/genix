import 'package:flutter/material.dart';

class CustomTransition extends PageRouteBuilder {
  final Widget enterWidget;
  CustomTransition(this.enterWidget)
      : super(
            opaque: false,
            pageBuilder: (context, animation, secondaryAnimation) =>
                enterWidget,
            transitionDuration: const Duration(milliseconds: 1500),
            reverseTransitionDuration: const Duration(milliseconds: 500),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              animation = CurvedAnimation(
                  parent: animation,
                  curve: Curves.fastLinearToSlowEaseIn,
                  reverseCurve: Curves.fastOutSlowIn);
              return ScaleTransition(
                scale: animation,
                alignment: const Alignment(-1, -1),
                child: child,
              );
            });
}
