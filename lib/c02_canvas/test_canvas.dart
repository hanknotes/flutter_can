import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;

class TestCanvas extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<TestCanvas> {
  @override
  Widget build(BuildContext context) {
//    final size = MediaQuery.of(context).size;
//    final width = size.width;
//    final height = size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text("test Canvas"),
      ),
      body: CustomPaint(
        painter: _MyPaint(),
        size: MediaQuery.of(context).size,
      ),
      backgroundColor: Colors.lightGreen[100],
    );
  }
}

class _MyPaint extends CustomPainter {
  Paint _gridPint; // 画笔
  Paint _paint = new Paint()..color = Colors.orangeAccent;
  final double step = 20; // 小格边长
  final double strokeWidth = .5; // 线宽
  final Color color = Colors.grey; // 线颜色

  _MyPaint() {
    _gridPint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;
  }
  @override
  void paint(Canvas canvas, Size size) {
    translateToCenter(canvas, size);
    _drawPaint1(canvas, size);
  }

  void _clipPath(Canvas canvas, Size size) {
    Path path = Path();
    path.lineTo(80, 80);
    path.lineTo(-80, 80);
    path.close();
    canvas.clipPath(path);
    canvas.drawPaint(new Paint()..color = Colors.redAccent);
  }

  void _drawPaint1(Canvas canvas, Size size) {
    Path path = Path();
    path.lineTo(80, 80);
    path.lineTo(-80, 80);
    path.close();
    canvas.clipPath(path);
    canvas.drawPaint(new Paint()..color = Colors.blueAccent);
  }

  void _clipRect(Canvas canvas, Size size) {
    var rect = Rect.fromCenter(center: Offset.zero, width: 180, height: 120);
//    canvas.clipRect(rect,doAntiAlias: true,clipOp: ui.ClipOp.intersect); // 裁剪画布  内
    canvas.clipRect(rect,
        doAntiAlias: true, clipOp: ui.ClipOp.difference); // 裁剪画布  外
//    canvas.clipRRect(RRect.fromRectAndRadius(rect, Radius.circular(30)),doAntiAlias: true); //

    canvas.drawPaint(new Paint()..color = Colors.redAccent);
  }

  void _clipDRect(Canvas canvas, Size size) {
    var rect = Rect.fromCenter(center: Offset.zero, width: 180, height: 120);
    canvas.clipRRect(RRect.fromRectAndRadius(rect, Radius.circular(30)),
        doAntiAlias: true); //
    canvas.drawPaint(new Paint()..color = Colors.redAccent);
  }

  void _drawxxx(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint
      ..color = Colors.redAccent[200]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;
  }

  void _transform(Canvas canvas, Size size) {
    Path path = Path();
    path.lineTo(60, 60);
    path.lineTo(-60, 60);
    path.lineTo(60, -60);
    path.lineTo(-60, -160);
    path.close();
    canvas.drawPath(path, _paint);
//    canvas.translate(140, 0);
    canvas.transform(Float64List.fromList(
        [
          1, 0, 0, 0,
          0, 1, 0, 0,
          0, 0, 1, 0,
          120, 0, 0, 1
        ]));
    canvas.drawPath(
        path,
        _paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
  }

  void _transform2(Canvas canvas, Size size) {
    Path path = Path();
    path.lineTo(60, 60);
    path.lineTo(-60, 60);
    path.lineTo(60, -60);
    path.lineTo(-60, -160);
    path.close();
    canvas.drawPath(path, _paint);
//    canvas.translate(140, 0);
    canvas.transform(Float64List.fromList(
        [
          1, 0, 0, 0,
          0, 1, 0, 0,
          0, 0, 1, 0,
          120, 0, 0, 1
        ]));
    canvas.drawPath(
        path,
        _paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
  }

  void _shader(Canvas canvas, Size size) {
    var rect = Rect.fromCenter(center: Offset.zero, width: 360, height: 240);
//    canvas.clipRect(rect,doAntiAlias: true,clipOp: ui.ClipOp.intersect); // 裁剪画布  内
//    canvas.clipRect(rect,doAntiAlias: true,clipOp: ui.ClipOp.difference); // 裁剪画布  外
//    canvas.clipRRect(RRect.fromRectAndRadius(rect, Radius.circular(30)),doAntiAlias: true); //
    Path path = Path();
    path.lineTo(80, 80);
    path.lineTo(-80, 80);
    path.close();
    canvas.clipPath(path);
    var colors = [
      Color(0xFFFF0000),
      Color(0xFF00FF00),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];
    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];
    _paint.shader = ui.Gradient.linear(
        rect.centerLeft, rect.centerRight, colors, pos, TileMode.clamp);
    _paint.blendMode = BlendMode.lighten;
    canvas.drawPaint(_paint);
  }

  void _drawPath(Canvas canvas, Size size) {
    Path path = Path();
    path.lineTo(60, 60);
    path.lineTo(-60, 60);
    path.lineTo(60, -60);
    path.lineTo(-60, -60);
    path.close();
    canvas.drawPath(path, _paint);
    canvas.translate(140, 0);
    canvas.drawPath(
        path,
        _paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
  }

  void _drawShadow(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint
      ..color = Colors.redAccent[200]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;
    Path path = Path();
    path.lineTo(80, 80);
    path.lineTo(-80, 80);
    path.close();

    canvas.drawShadow(path, Colors.red, 3, true);
    canvas.translate(200, 0);
    canvas.drawShadow(path, Colors.red, 3, false);
  }

  void _drawPaint(Canvas canvas, Size size) {
    var colors = [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];
    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];
    _paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, 0), colors, pos, TileMode.clamp);
    _paint.blendMode = BlendMode.lighten;
    canvas.drawPaint(_paint);
  }

  void _drawColor(Canvas canvas) {
    canvas.drawColor(Colors.blue, BlendMode.lighten);
  }

  void _drawFill(Canvas canvas) {
    canvas.save();
    canvas.translate(-200, 0);
    canvas.drawCircle(Offset(0, 0), 60, _paint);
    canvas.restore();

    var rect = Rect.fromCenter(center: Offset(0, 0), height: 100, width: 120);
    canvas.drawOval(rect, _paint);

    canvas.save();
    canvas.translate(150, 0);
    //drawArc(矩形区域,起始弧度,扫描弧度,是否连中心,画笔)
    canvas.drawArc(rect, 0, pi / 2 * 3, true, _paint);
    canvas.restore();

    canvas.save();
    canvas.translate(270, 0);
    //drawArc(矩形区域,起始弧度,扫描弧度,是否连中心,画笔)
    canvas.drawArc(rect, 0, pi / 2 * 3, false, _paint);
    canvas.restore();

    canvas.save();
    canvas.translate(0, 110);
    //drawArc(矩形区域,起始弧度,扫描弧度,是否连中心,画笔)
    canvas.drawArc(
        rect,
        0,
        pi / 2,
        true,
        _paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
    canvas.restore();
  }

  void _drawDRRect(Canvas canvas) {
    _paint
      ..color = Colors.orangeAccent
      ..strokeWidth = 1.5;
    Rect outRect =
        Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    Rect inRect =
        Rect.fromCenter(center: Offset(0, 0), width: 140, height: 100);
    canvas.drawDRRect(RRect.fromRectXY(outRect, 0, 0),
        RRect.fromRectXY(inRect, 20, 20), _paint);

//    Rect outRect2 =
//    Rect.fromCenter(center: Offset(0, 0), width: 60, height: 60);
//    Rect inRect2 =
//    Rect.fromCenter(center: Offset(0, 0), width: 40, height: 40);
//    canvas.drawDRRect(RRect.fromRectXY(outRect2, 15, 15),
//        RRect.fromRectXY(inRect2, 10, 10), _paint..color=Colors.green);
  }

  void _drawRRect(Canvas canvas) {
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    //【1】.圆角矩形fromRectXY构造
    Rect rectFromCenter =
        Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    canvas.drawRRect(RRect.fromRectXY(rectFromCenter, 40, 20), _paint);

    //【2】.圆角矩形fromLTRBXY构造
    canvas.drawRRect(RRect.fromLTRBXY(-120, -120, -80, -80, 10, 10),
        _paint..color = Colors.red);

    //【3】. 圆角矩形fromLTRBR构造
    canvas.drawRRect(RRect.fromLTRBR(80, -120, 120, -80, Radius.circular(10)),
        _paint..color = Colors.orange);

    //【4】. 圆角矩形fromLTRBAndCorners构造
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(80, 80, 120, 120,
            bottomRight: Radius.elliptical(10, 10)),
        _paint..color = Colors.green);

    //【5】. 矩形两点构造
    Rect rectFromPoints = Rect.fromPoints(Offset(-120, 80), Offset(-80, 120));
    canvas.drawRRect(
        RRect.fromRectAndCorners(rectFromPoints,
            bottomLeft: Radius.elliptical(10, 10)),
        _paint..color = Colors.purple);
  }

  void _drawRect(Canvas canvas) {
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    //【1】.矩形中心构造
    Rect rectFromCenter =
        Rect.fromCenter(center: Offset(0, 0), width: 160, height: 160);
    canvas.drawRect(rectFromCenter, _paint);
    //【2】.矩形左上右下构造
    Rect rectFromLTRB = Rect.fromLTRB(-120, -120, -80, -80);
    canvas.drawRect(rectFromLTRB, _paint..color = Colors.red);
    //【3】. 矩形左上宽高构造
    Rect rectFromLTWH = Rect.fromLTWH(80, -120, 40, 40);
    canvas.drawRect(rectFromLTWH, _paint..color = Colors.orange);
    //【4】. 矩形内切圆构造
    Rect rectFromCircle = Rect.fromCircle(center: Offset(100, 100), radius: 20);
    canvas.drawRect(rectFromCircle, _paint..color = Colors.green);
    //【5】. 矩形两点构造
    Rect rectFromPoints = Rect.fromPoints(Offset(-120, 80), Offset(-80, 120));
    canvas.drawRect(rectFromPoints, _paint..color = Colors.purple);
  }

  void _drawLines(Canvas canvas, Size size) {
    Paint _paint = new Paint()
      ..color = Colors.redAccent[200]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;

    canvas.drawLine(Offset(-120, -20), Offset(-80, -80), _paint);
    canvas.drawLine(Offset(-80, -80), Offset(-40, -40), _paint);
    canvas.drawLine(Offset(-40, -40), Offset(0, -100), _paint);
    canvas.drawLine(Offset(0, -100), Offset(40, -140), _paint);
    canvas.drawLine(Offset(40, -140), Offset(80, -160), _paint);
    canvas.drawLine(Offset(80, -160), Offset(120, -100), _paint);
  }

  void _drawRawPoints(Canvas canvas, Size size) {
    Float32List points = Float32List.fromList([
      -120,
      -20,
      -80,
      -80,
      -40,
      -40,
      0,
      -100,
      40,
      -140,
      80,
      -160,
      120,
      -100
    ]);

    Paint paint = new Paint();
    paint
      ..color = Colors.redAccent[200]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20;

//    canvas.drawRawPoints(PointMode.points, points, paint);
//    canvas.drawRawPoints(PointMode.lines, points, paint);
    canvas.drawRawPoints(PointMode.polygon, points, paint);
  }

  void _drawPoints(Canvas canvas, Size size) {
    final List<Offset> points = [
      Offset(-120, -20),
      Offset(-80, -80),
      Offset(-40, -40),
      Offset(0, -100),
      Offset(40, -140),
      Offset(80, -160),
      Offset(120, -100),
    ];

    Paint paint = new Paint();
    paint
      ..color = Colors.blue[200]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20;

//    canvas.drawPoints(PointMode.points, points, paint);
//    canvas.drawPoints(PointMode.lines, points, paint);
    canvas.drawPoints(PointMode.polygon, points, paint);
  }

  void _drawVertices(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint
      ..color = Colors.blue[200]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 20;
    canvas.drawVertices(
        Vertices(VertexMode.triangleFan,
            [Offset(50, 50), Offset(50, -50), Offset(-50, -50)],
            colors: [Colors.redAccent, Colors.blueAccent, Colors.green],
//            indices: [0,0,0],
//            textureCoordinates: [Offset(-50, -50), Offset(50, 50), Offset(-50, 50)]
        ),
        BlendMode.srcIn,
        paint);
  }

  void _drawSun(Canvas canvas, Size size) {
    int count = 12;
    Paint paint = new Paint();
    paint
      ..color = Colors.blue[200]
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset.zero, 100, paint);
    canvas.save();
    for (int i = 0; i < count; i++) {
      canvas.rotate(2 * pi / count);
      canvas.drawLine(
          Offset(0, 110),
          Offset(0, 130),
          paint
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2
            ..color = Colors.orangeAccent);
    }
    canvas.restore();
  }

  void _drawGrid(Canvas canvas, Size size) {
    // bottom right
    _drawBottomRight(canvas, size);

    // top right
    canvas.save();
    canvas.scale(1, -1); //沿x轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    // bottom left
    canvas.save();
    canvas.scale(-1, 1); //沿y轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    // top left
    canvas.save();
    canvas.scale(-1, -1); //沿原点镜像
    _drawBottomRight(canvas, size);
    canvas.restore();
  }

  void _drawBottomRight(Canvas canvas, Size size) {
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(size.width / 2, 0), _gridPint);
      canvas.translate(0, step);
    }
    canvas.restore();

    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      canvas.drawLine(Offset(0, 0), Offset(0, size.height / 2), _gridPint);
      canvas.translate(step, 0);
    }
    canvas.restore();
  }

  void testDrawCircle(Canvas canvas, Size size) {
    var paint = Paint()..color = Colors.blue;
    canvas.drawCircle(Offset(0, 0), 50, paint);
    canvas.drawLine(
        Offset(20, 20),
        Offset(50, 50),
        paint
          ..color = Colors.red
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);
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
