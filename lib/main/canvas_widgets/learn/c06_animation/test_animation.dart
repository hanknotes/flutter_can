import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class TestAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<TestAnimation>  with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(duration: Duration(seconds: 3), vsync: this);
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
    return Scaffold(
      appBar: AppBar(
        title: Text("test path"),
      ),
      body: CustomPaint(
        painter: _MyPaint(progress:_animationController),
        size: MediaQuery.of(context).size,
      ),
      backgroundColor: Colors.lightGreen[100],
    );
  }

  Future<ui.Image> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return decodeImageFromList(bytes);
  }
}

class _MyPaint extends CustomPainter {
  Paint _paint;
  final double strokeWidth = 0.5;
  final Color color = Colors.blue;
  final Animation<double> progress;
  _MyPaint({this.progress}) : super(repaint: progress);
  @override
  void paint(Canvas canvas, Size size) {
    translateToCenter(canvas, size);
    _testComputeMetrics2(canvas, size);
  }

  void _testComputeMetrics2(Canvas canvas, Size size) {

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    path.moveTo(0, 0);
    path.lineTo(0, -50);
    path.addRect(Rect.fromPoints(Offset(50,50), Offset(100,100)));

    path.addRRect(RRect.fromRectXY(Rect.fromPoints(Offset(50,-150), Offset(100,-50)),10,10));

    path.addOval(Rect.fromPoints(Offset(150,50), Offset(180,100)));

    PathMetrics pms = path.computeMetrics(forceClosed: false);

    pms.forEach((pm) {
      Tangent t = pm.getTangentForOffset(pm.length * progress.value);
      canvas.drawCircle(
          t.position, 5, Paint()..color = Colors.black);
    });
    canvas.drawPath(path, paint);

  }

  // 画布起点移到屏幕中心
  void translateToCenter(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
