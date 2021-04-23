import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';
// 柱状图   饼状图
class TestBar extends StatefulWidget {
  @override
  _TestBarState createState() => _TestBarState();
}

class _TestBarState extends State<TestBar> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return MyBar(_controller);
  }
}

class MyBar extends AnimatedWidget {
  Animation<double> animation;

  MyBar(this.animation) : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: MyPainter(animation),
      ),
    );
  }
}

class MyPainter extends CustomPainter {
  final double width = 400;
  final double height = 250;
  final double num = 5;
  Animation<double> animation;

  MyPainter(this.animation);

  @override
  void paint(Canvas canvas, Size size) {
    _translateToCenter(canvas, size);
    _drawBg(canvas, size);
    drawArcs(canvas, size);
  }

  // 饼状图
  void drawArcs(Canvas canvas, Size size) {
    Path clipPath = Path()
      ..lineTo(250, 0)
      ..arcTo(Rect.fromCircle(center: Offset(0, 0), radius: 250), 0,
          pi * 2 * animation.value, false);
    clipPath.close();
    if (animation.value != 1.0) {
      canvas.clipPath(clipPath);
    }
    List<String> texts = ["玉米", "黄豆", "小麦", "高粱", "葡萄"];
    List<Color> colors = [
      Colors.black12,
      Colors.redAccent,
      Colors.lightGreen,
      Colors.lightBlueAccent,
      Colors.yellowAccent
    ];
    List<String> pers = ["10%", "20%", "30%", "30%", "10%"];
    List<double> sweeps = [
      pi * 2 / 10,
      pi * 2 / 5,
      pi * 2 * 3 / 10,
      pi * 2 * 3 / 10,
      pi * 2 / 10
    ];
    canvas.save();
    for (int i = 0; i < texts.length; i++) {
      _drawArc(canvas, colors[i], texts[i], pers[i], 0, sweeps[i]);
      canvas.rotate(sweeps[i]);
    }
    canvas.restore();
  }

  void _drawArc(Canvas canvas, Color color, String text, String per,
      double startAngle, double sweepAngle) {
    double radius = 250;
    Paint paint = Paint()
      ..color = color
      ..isAntiAlias = true;
    Rect rect = Rect.fromCircle(center: Offset(0, 0), radius: radius);
    canvas.drawArc(rect, startAngle, sweepAngle, true, paint);
    canvas.save();
    canvas.rotate(sweepAngle / 2);
    TextPainter tp = TextPainter(
        text: TextSpan(text: per),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout(minWidth: radius);
    tp.paint(canvas, Offset.zero);

    Path path = Path();
    path.moveTo(radius, 0);
    path.lineTo(radius + 20, 0);
    path.relativeLineTo(10, 20);
    canvas.drawPath(
        path,
        paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1);

    TextPainter tp2 = TextPainter(
        text: TextSpan(text: text),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp2.layout();
    tp2.paint(canvas, Offset(radius + 10, 20));

    canvas.restore();
  }

  // 完整柱状图
  void drawBars(Canvas canvas, Size size) {
    _drawX(canvas, size);
    _drawY(canvas, size);
    _drawXDot(canvas, size);
    _drawYDot(canvas, size);
    _drawYMark(canvas, size);
    _drawXMark(canvas, size);
    _drawXLine(canvas, size);
    _drawBars(canvas, size);
  }

  // 完整折线图
  void drawPoints(Canvas canvas, Size size) {
    _drawX(canvas, size);
    _drawY(canvas, size);
    _drawXDot(canvas, size);
    _drawYDot(canvas, size);
    _drawYMark(canvas, size);
    _drawXMark(canvas, size);
    _drawXLine(canvas, size);
    _drawPoints(canvas, size);
  }

  // 折线
  void _drawPoints(Canvas canvas, Size size) {
    List<Offset> points = [];
    Paint _paint = new Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    double step = width / num;
    for (int i = 0; i < num; i++) {
      points.add(Offset(step / 2 + step * i, i & 1 == 1 ? -100 : -140));
    }
    canvas.drawPoints(PointMode.points, points, _paint);
    // canvas.drawPoints(PointMode.polygon, points, _paint..strokeWidth=1);
    Offset p1 = points[0];
    Path path = Path();
    path.moveTo(p1.dx, p1.dy);
    for (int i = 1; i < points.length; i++) {
      Offset px = points[i];
      path.lineTo(px.dx, px.dy);
    }
    PathMetrics pms = path.computeMetrics();
    pms.forEach((pm) {
      canvas.drawPath(pm.extractPath(0, pm.length * animation.value),
          _paint..strokeWidth = 1);
    });
  }

  // 柱
  void _drawBars(Canvas canvas, Size size) {
    Paint _paint = new Paint()
      ..color = Colors.blueAccent
      ..style = PaintingStyle.fill;
    double step = width / num;
    for (int i = 0; i < num; i++) {
      canvas.drawRect(
          Rect.fromPoints(Offset(step / 4 + step * i, 0),
              Offset(step * 3 / 4 + step * i, -200 * animation.value)),
          _paint);
    }
  }

  void _drawXLine(Canvas canvas, Size size) {
    Paint _paint = new Paint()
      ..color = Colors.black12
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    double step = height / num;
    for (int i = 1; i <= num; i++) {
      canvas.drawLine(Offset(width, -step * i), Offset(0, -step * i), _paint);
    }
  }

  void _drawXMark(Canvas canvas, Size size) {
    double step = width / num;
    for (int i = 0; i < num; i++) {
      var textPainter = TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          text: TextSpan(
              text: (i).toString() + "月",
              style: TextStyle(color: Colors.black)));
      textPainter.layout(minWidth: step);
      textPainter.paint(canvas, Offset(step * i, 5));
    }
  }

  void _drawYMark(Canvas canvas, Size size) {
    double step = height / num;
    for (int i = 0; i <= num; i++) {
      var textPainter = TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
          text: TextSpan(
              text: (20 * i).toString(),
              style: TextStyle(color: Colors.black)));
      textPainter.layout(minWidth: 40);
      textPainter.paint(canvas, Offset(-50, -step * i - 10));
    }
  }

  void _drawYDot(Canvas canvas, Size size) {
    Paint _paint = new Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    double step = height / num;
    for (int i = 1; i <= num; i++) {
      canvas.drawLine(Offset(-10, -step * i), Offset(0, -step * i), _paint);
    }
  }

  void _drawXDot(Canvas canvas, Size size) {
    Paint _paint = new Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    double step = width / num;
    for (int i = 1; i <= num; i++) {
      canvas.drawLine(Offset(step * i, 0), Offset(step * i, 10), _paint);
    }
  }

  void _drawY(Canvas canvas, Size size) {
    Paint _paint = new Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawLine(Offset(0, 10), Offset(0, -height), _paint);
  }

  void _drawX(Canvas canvas, Size size) {
    Paint _paint = new Paint()
      ..color = Colors.black54
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawLine(Offset(-10, 0), Offset(width, 0), _paint);
  }

  void _drawBg(Canvas canvas, Size size) {
    canvas.drawPaint(Paint()..color = Colors.grey[300]);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  void _translateToCenter(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
  }
}
