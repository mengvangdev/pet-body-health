import 'package:flutter/material.dart';

class ThreeDAxis extends StatelessWidget {
  const ThreeDAxis({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(300, 300),
      painter: AxisPainter(),
    );
  }
}

class AxisPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw the X axis
    canvas.drawLine(Offset(size.width / 2, size.height / 2),
        Offset(size.width / 2 + 100, size.height / 2), paint);
    // Draw the Y axis
    canvas.drawLine(Offset(size.width / 2, size.height / 2),
        Offset(size.width / 2, size.height / 2 - 100), paint);
    // Draw the Z axis
    canvas.drawLine(Offset(size.width / 2, size.height / 2),
        Offset(size.width / 2 - 70, size.height / 2 + 70), paint);

    // Draw axis labels
    _drawText(
        canvas, 'X', Offset(size.width / 2 + 110, size.height / 2), paint);
    _drawText(
        canvas, 'Y', Offset(size.width / 2, size.height / 2 - 110), paint);
    _drawText(
        canvas, 'Z', Offset(size.width / 2 - 80, size.height / 2 + 80), paint);
  }

  void _drawText(Canvas canvas, String text, Offset offset, Paint paint) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(color: Colors.black, fontSize: 16),
      ),
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(canvas, offset);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
