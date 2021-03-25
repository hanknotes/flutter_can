import 'dart:ui';
import 'dart:math';

import 'package:flutter/material.dart';

// 汽车仪表板
class TestDashBoard extends StatefulWidget {
  @override
  _TestBarState createState() => _TestBarState();
}

class _TestBarState extends State<TestDashBoard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: Duration(milliseconds: 3000));
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
  Animation<double> animation;
  double radius; // 半径
  double litterSweep; // 外层绿色 或 红色圆弧扫过的角度
  double bigSweep; // 外层蓝色圆弧扫过的角度
  double allAngle; // 外边圆弧总的角度
  double rotateAngle; // canvas旋转的角度
  double outerWidth = 15; // 外弧的宽度
  double singleAngle; // 每个刻度的角度

  MyPainter(Animation<double> animation) {
    this.animation = animation;
    radius = 200; // 半径
    litterSweep = pi * 2 / 4 * 3 / 5; // 外层绿色 或 红色圆弧扫过的角度
    bigSweep = pi * 9 / 10;
    rotateAngle = pi / 2 + (2 * pi - 2 * litterSweep - bigSweep) / 2;
    allAngle = litterSweep * 2 + bigSweep;
    singleAngle = allAngle / 110;
  }

  @override
  void paint(Canvas canvas, Size size) {
    _translateToCenter(canvas, size);
    _drawBg(canvas, size);
    drawOuter(canvas, size);
    drawDegrees(canvas, size);
    drawMiles(canvas, size);
    drawSpeedUnit(canvas, size);
    drawPointer(canvas, size);
  }

  // 画指针
  void drawPointer(Canvas canvas, Size size) {
    Path path = Path()
      ..moveTo(0, 0)
      ..lineTo(-15, 0)
      ..lineTo(-7, -7)
      ..lineTo(radius - 25, 0)
      ..lineTo(-7, 7)
      ..lineTo(-15, 0);
    path.close();
    double angle = animation.value * allAngle;
    print('animation.value='+animation.value.toString()+allAngle.toString());
    Color color = Colors.blue;
    if(angle<litterSweep){
      color = Colors.green;
    }else if(angle<litterSweep+bigSweep){
      color=Colors.blue;
    }else{
      color = Colors.red;
    }
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = color;
    canvas.rotate(angle);
    canvas.save();
    canvas.rotate(rotateAngle);
    canvas.drawPath(path, paint);
    canvas.drawCircle(Offset.zero, 3, paint..color = Colors.white);
    canvas.restore();

  }

  // 画速度及速度单位
  void drawSpeedUnit(Canvas canvas, Size size) {
    TextPainter tpUnit = TextPainter(
        text: TextSpan(
            text: "km/h",
            style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontStyle: FontStyle.italic)),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    tpUnit.layout();
    tpUnit.paint(
        canvas, Offset(-tpUnit.width / 2, -tpUnit.height / 2 - radius / 2));

    int speed = (animation.value*220).ceil();
    TextPainter tpSpeed = TextPainter(
        text: TextSpan(
            text: speed.toString(),
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontStyle: FontStyle.normal)),
        textDirection: TextDirection.ltr,
        textAlign: TextAlign.center);
    tpSpeed.layout();
    tpSpeed.paint(canvas, Offset(-tpSpeed.width / 2, radius / 2));
  }

  // 画里程
  void drawMiles(Canvas canvas, Size size) {
    Paint paint = Paint()..style = PaintingStyle.fill;
    canvas.save();
    canvas.rotate(rotateAngle);
    double mileAngle = singleAngle * 10;
    for (int i = 0; i <= 11; i++) {
      Color color = Colors.green;
      if (i < 3) {
        color = Colors.green;
      } else if (i < 9) {
        color = Colors.blue;
      } else {
        color = Colors.red;
      }
      Rect rect = Rect.fromCenter(center: Offset(0, 0), width: 30, height: 20);
      RRect rRect = RRect.fromRectAndRadius(rect, Radius.circular(5));
      canvas.save();
      canvas.translate(radius - outerWidth * 1.5 - 20, 0);
      canvas.rotate(-rotateAngle - mileAngle * i);
      canvas.drawRRect(rRect, paint..color = color);
      TextPainter tp = TextPainter(
          text: TextSpan(
              text: (i * 20).toString(), style: TextStyle(color: Colors.white)),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center);
      tp.layout(minWidth: 30);
      tp.paint(canvas, Offset(-15, -tp.height / 2));
      canvas.restore();
      canvas.rotate(mileAngle);
    }
    canvas.restore();
  }

  // 画刻度
  void drawDegrees(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.save();
    canvas.rotate(rotateAngle);
    for (int i = 0; i <= 110; i++) {
      Color color = Colors.green;
      if (singleAngle * i < litterSweep) {
        color = Colors.green;
      } else if (singleAngle * i <= (litterSweep + bigSweep)) {
        color = Colors.blue;
      } else {
        color = Colors.red;
      }
      double length = outerWidth;
      if (i % 10 != 0) {
        length = outerWidth / 2;
      }
      canvas.drawLine(Offset(radius - outerWidth / 2, 0),
          Offset(radius - outerWidth / 2 - length, 0), paint..color = color);
      canvas.rotate(singleAngle);
    }
    canvas.restore();
  }

  // 画最外层的弧
  void drawOuter(Canvas canvas, Size size) {
    Rect rect = Rect.fromCircle(center: Offset.zero, radius: radius);
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = outerWidth;

    canvas.save();
    canvas.rotate(rotateAngle);
    canvas.drawArc(rect, 0, litterSweep, false, paint..color = Colors.green);
    canvas.drawArc(
        rect, litterSweep, bigSweep, false, paint..color = Colors.blue);
    canvas.drawArc(rect, bigSweep + litterSweep, litterSweep, false,
        paint..color = Colors.red);
    canvas.restore();
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
