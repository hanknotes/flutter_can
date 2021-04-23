import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class TestCanvasPath extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<TestCanvasPath>  with SingleTickerProviderStateMixin {
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
//    final size = MediaQuery.of(context).size;
//    final width = size.width;
//    final height = size.height;
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
//  _MyPaint(Animation<double> progress) {
//    this.progress =progress;
//    _paint = Paint()
//      ..style = PaintingStyle.fill
//      ..strokeWidth = strokeWidth
//      ..color = color;
//  }
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

  void _testComputeMetrics(Canvas canvas, Size size) {

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
      Tangent t = pm.getTangentForOffset(pm.length * 0.5);
      canvas.drawCircle(
          t.position, 5, Paint()..color = Colors.black);
    });
    canvas.drawPath(path, paint);

  }

  void _testTransform(Canvas canvas, Size size) {

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    path.moveTo(0, 0);
    path.lineTo(0, -50);
    path.lineTo(-50, -50);
    Path path2 = path.transform(Float64List.fromList([
      1,    0, 0, 0,
      0,    1, 0, 0,
      0,    0, 1, 0,
      -100, -100, 0, 1,
    ]));
    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint);

  }


  void _testAdd(Canvas canvas, Size size) {

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

    Path path2 = Path();
    path2.moveTo(0, 0);
    path2.addArc(Rect.fromPoints(Offset(0,0), Offset(-180,180)), 0, pi);
    path.addPath(path2, Offset(0,100));
//    canvas.translate(-150, -150);
    canvas.drawPath(path, paint);

  }

  void _testCubicTo(Canvas canvas, Size size) {
    final Offset p1 = Offset(80, -150);
    final Offset p2 = Offset(160, 0);
    final Offset p3 = Offset(160, -160);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    path.moveTo(0, 0);
    path.lineTo(0, -50);
    //抛物线
    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    canvas.translate(0, -150);
    canvas.drawPath(path, paint);

    path.reset();
    path.moveTo(0, 0);
    path.lineTo(0, -50);
    path.cubicTo(p1.dx, p1.dy, p2.dx, p2.dy,p3.dx,p3.dy);
    canvas.translate(0, 250);
    canvas.drawPath(path, paint);

  }


  void _drawAconicTo(Canvas canvas, Size size) {
    final Offset p1 = Offset(80, -150);
    final Offset p2 = Offset(160, 0);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    path.moveTo(0, 0);
    path.lineTo(0, -50);
    //抛物线
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 3);
    canvas.translate(0, -150);
    canvas.drawPath(path, paint);

    path.reset();
    path.moveTo(0, 0);
    path.lineTo(0, -50);
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 1);
    canvas.translate(0, 150);
    canvas.drawPath(path, paint);

    path.reset();
    path.moveTo(0, 0);
    path.lineTo(0, -50);
    path.conicTo(p1.dx, p1.dy, p2.dx, p2.dy, 0.5);
    canvas.translate(0, 150);
    canvas.drawPath(path, paint);

    path.reset();
    path.moveTo(0, 0);
    path.lineTo(0, -50);
    path.relativeConicTo(p1.dx, p1.dy, p2.dx, p2.dy, 0.5);
    canvas.translate(0, 150);
    canvas.drawPath(path, paint);
  }

  void _drawRelativeArttoPoint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint
      ..color = Colors.redAccent[200]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    canvas.translate(0, -300);
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(80, -40);
    path.relativeArcToPoint(Offset(0, 80),
        radius: Radius.circular(60), largeArc: false, clockwise: false);
    canvas.drawPath(path, paint);

    canvas.translate(0, 150);
    path.reset();
    path.moveTo(0, 0);
    path.lineTo(80, -40);
    path.relativeArcToPoint(Offset(0, 40),
        radius: Radius.circular(60), largeArc: true, clockwise: false);
    canvas.drawPath(path, paint);

    canvas.translate(0, 150);
    path.reset();
    path.moveTo(0, 0);
    path.lineTo(80, -40);
    path.relativeArcToPoint(Offset(0, 40),
        radius: Radius.circular(60), largeArc: false, clockwise: true);
    canvas.drawPath(path, paint);

    canvas.translate(0, 150);
    path.reset();
    path.moveTo(0, 0);
    path.lineTo(80, -40);
    path.relativeArcToPoint(Offset(0, 40),
        radius: Radius.circular(60), largeArc: true, clockwise: true);
    canvas.drawPath(path, paint);
  }

  void _drawArttoPoint(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint
      ..color = Colors.redAccent[200]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    canvas.translate(0, -300);
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(80, -40);
    path.arcToPoint(Offset(80, 40),
        radius: Radius.circular(60), largeArc: false, clockwise: false);
    canvas.drawPath(path, paint);

    canvas.translate(0, 150);
    path.reset();
    path.moveTo(0, 0);
    path.lineTo(80, -40);
    path.arcToPoint(Offset(80, 40),
        radius: Radius.circular(60), largeArc: true, clockwise: false);
    canvas.drawPath(path, paint);

    canvas.translate(0, 150);
    path.reset();
    path.moveTo(0, 0);
    path.lineTo(80, -40);
    path.arcToPoint(Offset(80, 40),
        radius: Radius.circular(60), largeArc: false, clockwise: true);
    canvas.drawPath(path, paint);

    canvas.translate(0, 150);
    path.reset();
    path.moveTo(0, 0);
    path.lineTo(80, -40);
    path.arcToPoint(Offset(80, 40),
        radius: Radius.circular(60), largeArc: true, clockwise: true);
    canvas.drawPath(path, paint);
  }


  void _drawArtto(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint
      ..color = Colors.redAccent[200]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    Rect rect = Rect.fromCenter(center: Offset(0, 0), width: 300, height: 200);
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(40, 40);
    path.arcTo(rect,0, pi * 1.2, false);
    canvas.drawPath(path, paint);

    canvas.translate(0, -200);

    path.reset();
    path.moveTo(0, 0);
    path.lineTo(40, 40);
    path.arcTo(rect,0, pi * 1.2, true);
    canvas.drawPath(path, paint);

  }

  void _testMove(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint
      ..color = Colors.redAccent[200]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;
    Path path = Path();
    path.moveTo(-0,0);
    path.lineTo(80, 80);
    path.relativeLineTo(0, -80);
    path.close();

    path.relativeMoveTo(-80,-160);
    path.lineTo(80, -80);
    path.relativeLineTo(0, -80);

    canvas.drawPath(path, paint);
  }

  void _drawPath(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint
      ..color = Colors.redAccent[200]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(80, 80);
    path.relativeLineTo(0, -80);
    path.arcTo(Rect.fromPoints(Offset(0,-50), Offset(100,-80)), 0, pi/2, false);
    path.arcToPoint(Offset(0,-100),largeArc: true);
    path.relativeArcToPoint(Offset(90,-90));
    path.conicTo(200, -200, 100, -100, 1);
    path.relativeConicTo(200, -200, 100, -100, 1);
    path.cubicTo(0, -100, -100, 0, -100, 100);
    path.relativeCubicTo(0, -100, -100, 0, -100, 100);
    path.quadraticBezierTo(100, 100, 200, 100);
    path.relativeQuadraticBezierTo(-100, 100, 0, 100);
    path.addArc(Rect.fromPoints(Offset(0,-50), Offset(100,-80)), 0, pi);
    path.addOval(Rect.fromPoints(Offset(0,-50), Offset(100,-80)));
    path.addPath(Path()..lineTo(100, 100), Offset.zero);
    path.addPolygon([Offset(0,0),Offset(100,100)], false);
    path.addRect(Rect.fromPoints(Offset(0,-50), Offset(100,-80)));
    path.addRRect(RRect.fromRectXY(Rect.fromPoints(Offset(0,-50), Offset(100,-80)), 100, 200));

    PathMetrics pm = path.computeMetrics();
    bool iscontaint = path.contains(Offset(0,0));
    print("iscontain = "+iscontaint.toString());

    path.extendWithPath(Path()..moveTo(-100, -200)..lineTo(100,100), Offset.zero);
    path.close();
    canvas.drawPath(path, paint);

    Rect bound = path.getBounds();
    canvas.drawRect(bound, paint);

    canvas.drawPath(path.transform(Float64List.fromList([
      1, 0, 0, 0,
      0, 1, 0, 0,
      0, 0, 1, 0,
      0, -200, 0, 1,
    ])), paint);

    canvas.drawPath(path.shift(Offset(-100,0)), paint);
//    path
//      ..relativeMoveTo(0, 0)
//      ..relativeLineTo(100, 120)
//      ..relativeLineTo(-10, -60)
//      ..relativeLineTo(
//        60,
//        -10,
//      )
//      ..close();
//    canvas.drawPath(path, paint);
//    path.reset();
//    path
//      ..relativeMoveTo(-200, 0)
//      ..relativeLineTo(100, 120)
//      ..relativeLineTo(-10, -60)
//      ..relativeLineTo(
//        60,
//        -10,
//      )
//      ..close();
//
//    canvas.drawPath(path, paint);
  }

  void _drawxxx(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint
      ..color = Colors.redAccent[200]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;
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
