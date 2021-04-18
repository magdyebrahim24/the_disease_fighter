import 'dart:math';
import 'package:flutter/material.dart';

class ArcIndicator extends StatelessWidget {
  final progressValue;
  final Widget child;
  final dimensions;

  final Color bgColor;

  ArcIndicator(
      {this.progressValue,
      required this.child,
      this.dimensions,
      required this.bgColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Stack(
        clipBehavior: Clip.hardEdge,
        alignment: Alignment.center,
        fit: StackFit.loose,
        children: [
          CustomPaint(
            size: Size(dimensions.toDouble(), dimensions.toDouble()),
            foregroundPainter: ArcIndicatorPainter(
                width: 6,
                percent: progressValue,
                lineColor: Color(0xff9ADFF7),
                bgColor: bgColor),
          ),
          child
        ],
      ),
    );
  }
}

class ArcIndicatorPainter extends CustomPainter {
  final Color bgColor;
  final Color lineColor;
  final double percent;
  final double width;

  ArcIndicatorPainter(
      {required this.bgColor,
      required this.lineColor,
      required this.percent,
      required this.width});

  @override
  void paint(Canvas canvas, Size size) {
    Paint bgLine = Paint()
      ..color = bgColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = width
      ..style = PaintingStyle.fill;
    Paint completedLine = Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    Offset offset = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawArc(Rect.fromCircle(center: offset, radius: radius), 2.5, 100,
        false, bgLine);
    double sweepAngle = 2 * pi * percent;
    canvas.drawArc(Rect.fromCircle(center: offset, radius: radius - 3), -1.5,
        sweepAngle, false, completedLine);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
