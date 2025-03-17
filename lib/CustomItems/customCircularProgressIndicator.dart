import 'dart:math';

import 'package:flutter/material.dart';

class CustomCircularProgressIndicator extends StatefulWidget {
  final double dotSize; // Size of each dot
  final int dotCount;   // Number of dots
  final Color dotColor; // Color of the dots
  final Duration duration; // Animation duration
  final double size;    // Size of the entire progress indicator

  const CustomCircularProgressIndicator({
    Key? key,
    this.dotSize = 8.0,
    this.dotCount = 12,
    this.dotColor = Colors.grey,
    this.duration = const Duration(seconds: 1),
    this.size = 50.0,
  }) : super(key: key);

  @override
  _CustomCircularProgressIndicatorState createState() => _CustomCircularProgressIndicatorState();
}

class _CustomCircularProgressIndicatorState extends State<CustomCircularProgressIndicator> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            painter: _DotPainter(
              dotSize: widget.dotSize,
              dotCount: widget.dotCount,
              dotColor: widget.dotColor,
              animationValue: _controller.value,
            ),
          );
        },
      ),
    );
  }
}

class _DotPainter extends CustomPainter {
  final double dotSize;
  final int dotCount;
  final Color dotColor;
  final double animationValue;

  _DotPainter({
    required this.dotSize,
    required this.dotCount,
    required this.dotColor,
    required this.animationValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()..color = dotColor;
    final double radius = size.width / 2;
    final double angleStep = 2 * 3.141592653589793 / dotCount;

    for (int i = 0; i < dotCount; i++) {
      final double angle = i * angleStep + animationValue * 2 * 3.141592653589793;
      final Offset dotOffset = Offset(
        radius + radius * 0.75 * cos(angle),
        radius + radius * 0.75 * sin(angle),
      );
      canvas.drawCircle(dotOffset, dotSize / 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}