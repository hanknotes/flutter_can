import 'package:flutter/material.dart';

class C03 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        size: Size(300, 300),
        painter: TestPainter(),
      ),
    );
  }
}

class TestPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    drawBg(canvas, size);
    drawLines(canvas, size);
    drawCheck(canvas, size);
  }

  void drawBg(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Colors.orangeAccent;
    canvas.drawRect(Offset.zero & size, paint);
  }

  void drawLines(Canvas canvas, Size size) {
    double width = size.width / 15;
    double height = size.height / 15;
    Paint paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = Colors.black87;

    for (int i = 0; i <= 15; i++) {
      double y = height * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);

      double x = width * i;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  void drawCheck(Canvas canvas, Size size) {
    double width = size.width / 15;
    Paint paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill
      ..color = Colors.red;
    for (int i = 0; i <= 15; i++) {
      double x = width * i;
      double y = width * i;
      canvas.drawCircle(Offset(x,y), width / 2, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
