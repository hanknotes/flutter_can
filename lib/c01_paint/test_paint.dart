import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';

class TestPaint extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestPaintState();
  }
}

class TestPaintState extends State<TestPaint> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test paint"),
      ),
      body: CustomPaint(
        painter: _MyPaint(),
        size: Size(380, 560),
      ),
      backgroundColor: Colors.lightGreen[100],
    );
  }
}

class _MyPaint extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    translateToCenter(canvas, size);
    _drawInvertColors(canvas);
  }

  void _testPaint(Canvas canvas) {
    Paint _paint = Paint()
      ..color = Colors.redAccent // 画笔的颜色
      ..isAntiAlias = false // 是否抗锯齿，表示让边缘更加圆滑
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.square
      ..strokeJoin = StrokeJoin.round
      ..strokeMiterLimit = 2
      ..invertColors = true
      ..blendMode = BlendMode.srcIn;
//    ..colorFilter = ColorFilter.
//    ..imageFilter
//    ..maskFilter
//    ..filterQuality
    canvas.drawCircle(Offset(500, 0), 500, _paint..invertColors = false);
    canvas.drawCircle(Offset(200, 500), 150, _paint..invertColors = true);
  }

  void _drawInvertColors(Canvas canvas) {
    Paint _paint = Paint();
    _paint..color = Colors.redAccent;
    canvas.drawCircle(Offset(0, -100), 100, _paint..invertColors = false);
    canvas.drawCircle(Offset(0, 100), 100, _paint..invertColors = true);
  }

  void drawStrokeMiterLimit(Canvas canvas) {
    Paint paint = Paint();
    Path path = Path();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeJoin = StrokeJoin.miter
      ..strokeWidth = 20;
    for (int i = 0; i < 4; i++) {
      path.reset();
      path.moveTo(50 + 150.0 * i, 50);
      path.lineTo(50 + 150.0 * i, 150);
      path.relativeLineTo(100, -(40.0 * i + 20));
      canvas.drawPath(path, paint..strokeMiterLimit = 2);
    }
    for (int i = 0; i < 4; i++) {
      path.reset();
      path.moveTo(50 + 150.0 * i, 50 + 150.0);
      path.lineTo(50 + 150.0 * i, 150 + 150.0);
      path.relativeLineTo(100, -(40.0 * i + 20));
      canvas.drawPath(path, paint..strokeMiterLimit = 3);
    }
  }

  void drawStrokeJoin(Canvas canvas) {
    Paint paint = Paint();
    Path path = Path();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 20;
    path.moveTo(-80, -50);
    path.lineTo(-50, 0);
    path.lineTo(0, -50);
    path.lineTo(50, 0);
    path.lineTo(80, -50);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.bevel);

    canvas.translate(0, -150);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.miter);

    canvas.translate(0, 300);
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.round);
  }

  void _drawStrokeMiterLimit(Canvas canvas) {
    Paint paint = Paint();
    Path path = Path();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.redAccent
      ..strokeJoin = StrokeJoin.miter
      ..strokeWidth = 20;
    path.moveTo(-80, -50);
    path.lineTo(-50, 0);
    path.lineTo(0, -50);
    path.lineTo(50, 0);
    path.lineTo(60, -100);

    canvas.translate(0, -150);
    canvas.drawPath(path, paint..strokeMiterLimit = 1);

    canvas.translate(0, 150);
    canvas.drawPath(path, paint..strokeMiterLimit = 2);

    canvas.translate(0, 150);
    canvas.drawPath(path, paint..strokeMiterLimit = 3);
  }

  void _drawStrokeCap(Canvas canvas) {
    Paint paint = Paint();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 20;
    Offset start = Offset(-50, 0);
    Offset end = Offset(50, 0);

    canvas.drawLine(start, end, paint..strokeCap = StrokeCap.butt);
    canvas.translate(0, -50);
    canvas.drawLine(start, end, paint..strokeCap = StrokeCap.round);
    canvas.translate(0, 100);
    canvas.drawLine(start, end, paint..strokeCap = StrokeCap.square);
  }

  void _drawStrokeCapArc(Canvas canvas) {
    Paint paint = Paint();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.red[200]
      ..strokeWidth = 10;
    Rect rect = Rect.fromCenter(center: Offset(0, 0), width: 100, height: 100);
    double start = pi / 2;
    double end = pi;
    canvas.drawArc(rect, start, end, false, paint..strokeCap = StrokeCap.butt);
    canvas.translate(0, -120);
    canvas.drawArc(rect, start, end, false, paint..strokeCap = StrokeCap.round);
    canvas.translate(0, 240);
    canvas.drawArc(
        rect, start, end, false, paint..strokeCap = StrokeCap.square);
  }

  void testStroke(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Colors.red;
    canvas.drawCircle(
        Offset(180, 180),
        150,
        paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 50);
    canvas.drawCircle(
        Offset(180 + 360.0, 180),
        150,
        paint
          ..strokeWidth = 50
          ..style = PaintingStyle.fill);
  }

  void testDrawRect(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.orangeAccent
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    canvas.drawPaint(paint);

    paint..color = Colors.lightGreen;
    canvas.drawRect(Offset.zero & size, paint);

    paint..color = Colors.grey;
    canvas.drawRect(
        Rect.fromCenter(center: Offset(100, 100), width: 100, height: 100),
        paint);

    paint..color = Colors.redAccent;
    canvas.drawRect(
        Rect.fromCircle(center: Offset(200, 200), radius: 50), paint);

    paint..color = Colors.blue;
    canvas.drawRect(Rect.fromLTRB(10, 15, 100, 150), paint);

    paint..color = Colors.pinkAccent;
    canvas.drawRect(Rect.fromLTWH(0, 400, 100, 100), paint);

    paint..color = Colors.deepOrange;
    canvas.drawRect(Rect.fromPoints(Offset(300, 300), Offset(350, 400)), paint);
  }

  void testDrawRRect(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.orangeAccent
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;

    canvas.drawPaint(paint);

    paint..color = Colors.black12;
    canvas.drawRRect(
        RRect.fromLTRBAndCorners(10, 10, 100, 100,
            topLeft: Radius.circular(10)),
        paint);

    paint..color = Colors.green;
    canvas.drawRRect(
        RRect.fromLTRBR(10, 150, 150, 200, Radius.circular(10)), paint);

    paint..color = Colors.deepOrange;
    canvas.drawRRect(RRect.fromLTRBXY(100, 10, 250, 200, 10, 20), paint);

    paint..color = Colors.deepOrange;
    canvas.drawRRect(RRect.fromLTRBXY(100, 10, 250, 200, 10, 20), paint);
  }

  void testDrawDRRect(Canvas canvas, Size size) {
    var paint = new Paint()
      ..color = Colors.orange[200]
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    // 画矩形
    Rect rect1 = Rect.fromCircle(center: Offset(200, 200), radius: 140);
    Rect rect2 = Rect.fromCircle(center: Offset(200, 200), radius: 160);
    RRect rRect1 = RRect.fromRectAndRadius(rect1, Radius.circular(20));
    RRect rRect2 = RRect.fromRectAndRadius(rect2, Radius.circular(20));
    canvas.drawDRRect(rRect2, rRect1, paint);
  }

  void testDrawCircle(Canvas canvas, Size size) {
    var paint = new Paint()
      ..color = Colors.orange[200]
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    // 画矩形
    canvas.drawRect(Offset.zero & size, paint);

    paint..color = Colors.blue[200];
    canvas.drawCircle(Offset(200, 200), 100, paint);
  }

  void testDrawOval(Canvas canvas, Size size) {
    var paint = new Paint()
      ..color = Colors.orange[200]
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    // 画矩形
    canvas.drawRect(Offset.zero & size, paint);

    paint..color = Colors.blue[200];
    canvas.drawOval(
        Rect.fromCenter(width: 200, height: 300, center: Offset(150, 250)),
        paint);
  }

  void testDrawLine(Canvas canvas, Size size) {
    var paint = new Paint()
      ..color = Colors.orange[200]
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    // 画矩形
    canvas.drawRect(Offset.zero & size, paint);

    paint
      ..color = Colors.black
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(100, 150), Offset(250, 150), paint);
  }

  void testDrawColor(Canvas canvas, Size size) {
    var paint = new Paint()
      ..color = Colors.orange[200]
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    // 画矩形
    canvas.drawColor(Colors.blue[200], BlendMode.srcIn);
    canvas.drawRect(Offset.zero & size / 2, paint);
  }

  void testDrawPoints(Canvas canvas, Size size) {
    var paint = new Paint()
      ..color = Colors.orange[200]
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    // 画矩形
    canvas.drawRect(Offset.zero & size, paint);
    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 15
      ..strokeCap = StrokeCap.round
      ..color = Colors.black;
    canvas.drawPoints(
//        PointMode.points,// 单独的点
//    PointMode.polygon,// 所有的点按给定顺序连成线
        PointMode.lines, //画一条线，起始点为给定数组的前两个点
        [Offset(100, 100), Offset(300, 100), Offset(200, 300)],
        paint);
  }

  // path
  void testDrawPath(Canvas canvas, Size size) {
    var paint = new Paint()
      ..color = Colors.orange[200]
//      ..style = PaintingStyle.fill
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..isAntiAlias = true;
    // 画矩形
    Path path = Path();
    path.moveTo(100, 100);
    path.lineTo(100, 200);
    path.lineTo(200, 100);
    path.lineTo(200, 200);
    path.close();
    canvas.drawPath(path, paint);
  }

  void testDrawPath2(Canvas canvas, Size size) {
    var paint = new Paint()
      ..color = Colors.red[200]
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..isAntiAlias = true;
    Path path = new Path();
    path.moveTo(100, 100);
    path.lineTo(200, 0);
    path.lineTo(200, 100);
    path.close();
    canvas.drawPath(path, paint);
  }

  // 圆弧
  void testDrawArc(Canvas canvas, Size size) {
    var paint = new Paint()
      ..color = Colors.orange[200]
//      ..style = PaintingStyle.fill
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..isAntiAlias = true;
//    Rect rect = Rect.fromCircle(
//        center: Offset(200, 200), radius: 100);
    Rect rect = Rect.fromLTRB(10, 10, 100, 200);
    canvas.drawArc(rect, 0, 2.14, true, paint);
//    canvas.drawArc(rect, 0, 3.14, true, paint);
  }

  // 阴影
  void testDrawShadow(Canvas canvas, Size size) {
    var paint = new Paint()
      ..color = Colors.orange[200]
      ..style = PaintingStyle.fill
      ..strokeWidth = 5
      ..isAntiAlias = true;
    Path path = Path();
    path.moveTo(100, 100);
    path.lineTo(100, 200);
    path.lineTo(200, 100);
    path.lineTo(200, 200);
    canvas.drawPath(path, paint);
    canvas.drawShadow(path, Colors.orange, 5, true);
  }

  // save()  saveLayer  restore
  void testSaveRestore(Canvas canvas, Size size) {
    var paint = new Paint()
      ..color = Colors.orange[200]
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    canvas.drawPaint(paint); // 整个区域
    paint..color = Colors.blue[200];
    canvas.drawRect(Offset.zero & size, paint); // 绘制区域
    paint..color = Colors.green[200];
    canvas.drawRect(
        Rect.fromCircle(center: Offset(200, 200), radius: 100), paint);
    // 保存之前的绘制内容
    canvas.save();
    // 接着绘制一个矩形,是在前面的图层上继续绘制的
    paint.color = Colors.grey;
    canvas.drawRect(
        Rect.fromCircle(center: Offset(250, 250), radius: 100), paint);
    // 保存
    canvas.restore();
    // 设定混合模式
    paint.blendMode = BlendMode.src;
    //保存之前并新建一个图层，并指定新图层的区域与混合模式
    canvas.saveLayer(
        Rect.fromCircle(center: Offset(270, 350), radius: 100), paint);
    paint..color = Colors.redAccent;
    canvas.drawRect(Offset.zero & size, paint); // 绘制区域
    paint..color = Colors.orange;
    //在新的图层上画一个矩形，设定矩形范围超过图层范围
    canvas.drawRect(
        Rect.fromCircle(center: Offset(300, 350), radius: 120), paint);
    // 保存
    canvas.restore();
  }

  // 平移
  void testTranslate(Canvas canvas, Size size) {
    var paint = new Paint()
      ..color = Colors.orange[200]
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    // 初始位置
    canvas.drawRect(Offset.zero & size / 2, paint); // 绘制区域
    paint..color = Colors.green[200];
    canvas.drawRect(
        Rect.fromCircle(center: Offset(100, 100), radius: 50), paint); // 画一个矩形
    // 保存之前的绘制内容
    canvas.save();
    canvas.translate(200, 200); //向xy200平移
    paint.color = Colors.red[200];
    canvas.drawRect(Offset.zero & size / 2, paint); // 绘制canvas区域
    paint.color = Colors.green[200];
    canvas.drawRect(
        Rect.fromCircle(center: Offset(100, 100), radius: 50), paint); // 画一个矩形
    // 保存
    canvas.restore();
  }

  // 缩放
  void testScale(Canvas canvas, Size size) {
    var paint = new Paint()
      ..color = Colors.orange[200]
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    // 初始位置
    canvas.drawRect(Offset.zero & size / 2, paint); // 绘制区域
    paint..color = Colors.green[200];
    canvas.drawRect(
        Rect.fromCircle(center: Offset(100, 100), radius: 50), paint); // 画一个矩形
    // 保存之前的绘制内容
    canvas.save();
    canvas.scale(0.5, 0.5); // 缩小为原来的一半
    paint.color = Colors.red[200];
    canvas.drawRect(Offset.zero & size / 2, paint); // 绘制canvas区域
    paint.color = Colors.green[200];
    canvas.drawRect(
        Rect.fromCircle(center: Offset(100, 100), radius: 50), paint); // 画一个矩形
    // 保存
    canvas.restore();
  }

  // 旋转
  void testRotate(Canvas canvas, Size size) {
    var paint = new Paint()
      ..color = Colors.orange[200]
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    // 初始位置
    canvas.drawRect(Offset.zero & size / 2, paint); // 绘制区域
    paint..color = Colors.green[200];
    canvas.drawRect(
        Rect.fromCircle(center: Offset(100, 100), radius: 50), paint); // 画一个矩形
    // 保存之前的绘制内容
    canvas.save();
    canvas.translate(200, 200); //向xy200平移
    canvas.rotate(1); // 旋转1弧度
    paint.color = Colors.red[200];
    canvas.drawRect(Offset.zero & size / 2, paint); // 绘制canvas区域
    paint.color = Colors.green[200];
    canvas.drawRect(
        Rect.fromCircle(center: Offset(100, 100), radius: 50), paint); // 画一个矩形
    // 保存
    canvas.restore();
  }

  // 斜切
  void testSkew(Canvas canvas, Size size) {
    var paint = new Paint()
      ..color = Colors.orange[200]
      ..style = PaintingStyle.fill
      ..isAntiAlias = true;
    // 初始位置
    canvas.drawRect(Offset.zero & size / 2, paint); // 绘制区域
    paint..color = Colors.green[200];
    canvas.drawRect(
        Rect.fromCircle(center: Offset(100, 100), radius: 50), paint); // 画一个矩形
    // 保存之前的绘制内容
    canvas.save();
//    canvas.skew(pi/4, 0);//
    canvas.skew(tan(60), 0); //
    paint.color = Colors.red[200];
    canvas.drawRect(Offset.zero & size / 2, paint); // 绘制canvas区域
    paint.color = Colors.green[200];
    canvas.drawRect(
        Rect.fromCircle(center: Offset(100, 100), radius: 50), paint); // 画一个矩形
    // 保存
    canvas.restore();
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
