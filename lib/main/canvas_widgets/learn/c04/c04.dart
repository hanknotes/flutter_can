import 'package:flutter/material.dart';
import 'dart:math';

class C04 extends StatefulWidget {
  @override
  _C04State createState() => _C04State();
}

class _C04State extends State<C04> with TickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    super.initState();
    _animationController =
        new AnimationController(vsync: this, duration: Duration(seconds: 3),upperBound: 2.0);
    bool isForward = true;
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.forward) {
        isForward = true;
      } else if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        if (isForward) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      } else if (status == AnimationStatus.reverse) {
        isForward = false;
      }
    });
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (BuildContext context, Widget child) {
        return MyIndicator(_animationController.value);
      },
    );
  }
}

class MyIndicator extends StatelessWidget {
  final double value;
  MyIndicator(this.value);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: MyCircle(value),
      ),
    );
  }
}

class MyCircle extends CustomPainter {
  final double value;
  MyCircle(this.value);
  @override
  void paint(Canvas canvas, Size size) {
    drawBottomCircle(canvas, size);
    drawTopProcess2(canvas, size);
    canvas.getSaveCount();
  }

  void drawBottomCircle(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..isAntiAlias = true;
    Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 100);
    canvas.drawArc(rect, 0, pi * 2, false, paint);
  }

  void drawTopProcess(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.redAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..isAntiAlias = true;
    Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 100);
    canvas.drawArc(rect, 0, pi * value, false, paint);
  }

  void drawTopProcess2(Canvas canvas, Size size) {
    Rect rect = Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2), radius: 100);
    Rect rect2 = Offset(5, 5) & Size(
        size.width - 10,
        size.height - 10
    );
    Paint paint = Paint()
//      ..color = Colors.redAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..shader = SweepGradient(
          startAngle: 0,
          endAngle: pi * value,
          colors: [Colors.redAccent, Colors.blue, Colors.green],
          stops: [0.2, 0.5, 0.8]).createShader(rect2)
      ..isAntiAlias = true;

    canvas.drawArc(rect, 0, pi * value, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
