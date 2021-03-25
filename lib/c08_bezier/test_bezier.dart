import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

/**
 * 波浪图
 */
class TestBeizer extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<TestBeizer>  with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    _animationController.repeat();
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
  final double waveWidth = 80;
  final double wrapHeight =100; // 包裹高度
  final double waveHeight = 20;
  _MyPaint({this.progress}) : super(repaint: progress);
  @override
  void paint(Canvas canvas, Size size) {
    translateToCenter(canvas, size);
    _testBeizer(canvas, size);
  }

  void _testBeizer(Canvas canvas, Size size) {
    // canvas.clipRect((Rect.fromCenter(
    //     center: Offset( -waveWidth, 0),width: waveWidth*2,height: 200.0)));
    canvas.clipPath(Path()..addOval(Rect.fromCenter(center: Offset( -waveWidth, 0),width: waveWidth*2,height: 200.0)));
    canvas.save();
    canvas.translate(-2 * waveWidth + 2 * waveWidth * progress.value, 0);

    Path path = getPath();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;
    // path.moveTo(0, 0);

    canvas.translate(-2 * waveWidth, 0);
    canvas.drawPath(path, paint..color=Colors.grey[500]);

    canvas.translate(-waveWidth*3/2, 0);
    canvas.drawPath(path, paint..color = Colors.purpleAccent);
    canvas.restore();

  }

  Path getPath(){
    Path path = Path();
    path.moveTo(0, 0);
    path.relativeQuadraticBezierTo(waveWidth/2, -waveHeight, waveWidth, 0);
    path.relativeQuadraticBezierTo(waveWidth/2, waveHeight, waveWidth, 0);
    path.relativeQuadraticBezierTo(waveWidth/2, -waveHeight, waveWidth, 0);
    path.relativeQuadraticBezierTo(waveWidth/2, waveHeight, waveWidth, 0);
    path.relativeQuadraticBezierTo(waveWidth/2, -waveHeight, waveWidth, 0);
    path.relativeQuadraticBezierTo(waveWidth/2, waveHeight, waveWidth, 0);
    path.relativeLineTo(0, wrapHeight);
    path.relativeLineTo(-waveWidth*2 * 2.0, 0);
    path.close();
    return path;
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
