import 'package:flutter/material.dart';

class GlowingCircularLoadingIndicator extends StatefulWidget {
  final double size;
  final Color glowColor;

  const GlowingCircularLoadingIndicator({
    Key? key,
    this.size = 30.0,
    this.glowColor = Colors.blueAccent,
  }) : super(key: key);

  @override
  _GlowingCircularLoadingIndicatorState createState() =>
      _GlowingCircularLoadingIndicatorState();
}

class _GlowingCircularLoadingIndicatorState
    extends State<GlowingCircularLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // Continuous rotation animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withOpacity(0.6),
                spreadRadius: _controller.value * 4,
                blurRadius: _controller.value * 6,
              ),
            ],
          ),
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(widget.glowColor),
          ),
        );
      },
    );
  }
}
