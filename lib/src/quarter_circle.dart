import 'package:flutter/material.dart';
import 'dart:math' as math;


class QuarterCircle extends StatelessWidget {
  final CircleAlignment circleAlignment;
  final Color color;

  const QuarterCircle({Key? key, required this.circleAlignment, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: CustomPaint(
        painter: _QuarterCirclePainter(
          circleAlignment: circleAlignment,
          color: color,
        ),
      ),
    );
  }
}


class _QuarterCirclePainter extends CustomPainter {
  final CircleAlignment circleAlignment;
  final Color color;

  const _QuarterCirclePainter({required this.circleAlignment,required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final radius = math.min(size.height, size.width);
    final offset = circleAlignment == CircleAlignment.topLeft
        ? Offset(.0, .0)
        : circleAlignment == CircleAlignment.topRight
        ? Offset(size.width, .0)
        : circleAlignment == CircleAlignment.bottomLeft
        ? Offset(.0, size.height)
        : Offset(size.width, size.height);
    canvas.drawCircle(offset, radius, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_QuarterCirclePainter oldDelegate) {
    return color == oldDelegate.color &&
        circleAlignment == oldDelegate.circleAlignment;
  }
}

enum CircleAlignment {
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
}