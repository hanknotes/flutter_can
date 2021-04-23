import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class C05Matrix extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<C05Matrix> {
  ui.Image _src;
  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    _src = await loadImageFromAssets('images/a2.png');
    setState(() {});
  }

  Future<ui.Image> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    List<int> bytes =
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return decodeImageFromList(bytes);
  }
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
        painter: _MyPaint(_src),
        size: MediaQuery.of(context).size,
      ),
      backgroundColor: Colors.lightGreen[100],
    );
  }
}

class _MyPaint extends CustomPainter {
  Paint _paint = new Paint()..color = Colors.orangeAccent;
  final double step = 20; // 小格边长
  final double strokeWidth = .5; // 线宽
  final Color color = Colors.grey; // 线颜色
  ui.Image _src;

  _MyPaint(this._src);

  @override
  void paint(Canvas canvas, Size size) {
    translateToCenter(canvas, size);
    _testColorFilter(canvas, size);
  }


  void _testColorFilter(Canvas canvas, Size size) {
    Paint paint = Paint();
    //  灰度颜色过滤器  照片颜色变给白
    paint.colorFilter = ColorFilter.matrix(<double>[
           0.2126, 0.7152, 0.0722, 0, 0,
           0.2126, 0.7152, 0.0722, 0, 0,
           0.2126, 0.7152, 0.0722, 0, 0,
           0,      0,      0,      1, 0,
         ]);
    //  暗褐色色调的颜色  照片颜色变给老久  泛黄
    paint.colorFilter = ColorFilter.matrix(<double>[
       0.393, 0.769, 0.189, 0, 0,
       0.349, 0.686, 0.168, 0, 0,
       0.272, 0.534, 0.131, 0, 0,
       0,     0,     0,     1, 0,
     ]);
    //  反转颜色矩阵
    paint.colorFilter = ColorFilter.matrix(<double>[
      -1,  0,  0, 0, 255,
      0, -1,  0, 0, 255,
      0,  0, -1, 0, 255,
      0,  0,  0, 1,   0,
    ]);
    //  去除红色
    paint.colorFilter = ColorFilter.matrix(<double>[
       0, 0, 0, 0, 0,
       0, 1, 0, 0, 0,
       0, 0, 1, 0, 0,
       0, 0, 0, 1, 0,
     ]);
    //  改变透明度
    paint.colorFilter = ColorFilter.matrix(<double>[
      1, 0, 0, 0, 0,
      0, 1, 0, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 0, 0.5, 0,
    ]);
//
    // 泛白效果  构造一个将sRGB gamma曲线应用于RGB的颜色过滤器频道
    paint.colorFilter = ColorFilter.linearToSrgbGamma();
//
    // 泛白的反效果，有点清纯黑，创建应用sRGB gamma曲线反转的颜色过滤器到RGB通道。
    paint.colorFilter = ColorFilter.srgbToLinearGamma();
    canvas.drawImage(
        _src, Offset(-_src.width/2,-_src.height/2), paint);
  }
  void _testGradientLinear(Canvas canvas, Size size) {
    Paint _paint = Paint();
    _paint.isAntiAlias = true;
    _paint.style = PaintingStyle.stroke;
    _paint.strokeWidth = 30;
    _paint.shader = ui.Gradient.linear(
      Offset(-100, 0),
      Offset(100, 0),
      [Colors.red, Colors.blue, Colors.green],
      [0.2, 0.4, 0.6],
//        TileMode.clamp,
//      TileMode.repeated,
      TileMode.mirror,
      Float64List.fromList([
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1,
      ]),
    );
    canvas.drawLine(Offset(-150, 0), Offset(150, 0), _paint);

    _paint.shader = ui.Gradient.linear(
      Offset(-100, 0),
      Offset(100, 0),
      [Colors.red, Colors.blue, Colors.green],
      [0.2, 0.4, 0.6],
//        TileMode.clamp,
//      TileMode.repeated,
      TileMode.mirror,
      Float64List.fromList([
        0.3, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1,
      ]),
    );
    canvas.drawLine(Offset(-150, 40), Offset(150, 40), _paint);
  }

  void _testGradientRadial(Canvas canvas, Size size) {
    Paint _paint = Paint();
    _paint.isAntiAlias = true;
    _paint.style = PaintingStyle.fill;
    _paint.strokeWidth = 1;

    _paint.shader = ui.Gradient.radial(
      Offset(0, -150),
      80,
      [Colors.red, Colors.blue, Colors.green],
      [0.2, 0.4, 0.8],
//      TileMode.clamp,
      TileMode.repeated,
        Float64List.fromList([
        1, 0, 0, 0,
    0, 1, 0, 0,
    0, 0, 1, 0,
    0, 0, 0, 1,
        ])
//      TileMode.mirror,
    );
    canvas.drawCircle(Offset(0, -150), 150, _paint);

    _paint.shader = ui.Gradient.radial(
      Offset(0, 150),
      80,
      [Colors.red, Colors.blue, Colors.green],
      [0.2, 0.4, 0.8],
//      TileMode.clamp,
      TileMode.repeated,
        Float64List.fromList([
          0.3, 0, 0, 0,
          0, 1, 0, 0,
          0, 0, 1, 0,
          0, 0, 0, 1,
        ])
//      TileMode.mirror,
    );

    canvas.drawCircle(Offset(0, 150), 150, _paint);
  }

  void _testGradientRadialFocol(Canvas canvas, Size size) {
    Paint _paint = Paint();
    _paint.isAntiAlias = true;
    _paint.style = PaintingStyle.fill;
    _paint.strokeWidth = 1;

    _paint.shader = ui.Gradient.radial(
        Offset(0, 0),
        80,
        [Colors.red, Colors.blue, Colors.green],
        [0.2, 0.4, 0.8],
//      TileMode.clamp,
        TileMode.repeated,
//      TileMode.mirror,
        Float64List.fromList([
          1, 0, 0, 0,
          0, 1, 0, 0,
          0, 0, 1, 0,
          0, 0, 0, 1,
        ]),
        Offset(40,1),
        5
    );
    canvas.drawCircle(Offset(0, 0), 200, _paint);
  }

  void _testGradientSweep(Canvas canvas, Size size) {
    Paint _paint = Paint();
    _paint.isAntiAlias = true;
    _paint.style = PaintingStyle.fill;
    _paint.strokeWidth = 1;

    _paint.shader = ui.Gradient.sweep(
        Offset(0, -150),
        [Colors.red, Colors.blue, Colors.green],
        [0.3, 0.5, 1],
//      TileMode.clamp,
      TileMode.repeated,
//        TileMode.mirror,
        0,
        pi/2,
      Float64List.fromList([
        1, 0, 0, 0,
        0, 1, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1,
      ]),
    );
    canvas.drawCircle(Offset(0, -150), 150, _paint);

    _paint.shader = ui.Gradient.sweep(
        Offset(0, 150),
        [Colors.red, Colors.blue, Colors.green],
        [0.3, 0.5, 1],
//      TileMode.clamp,
      TileMode.repeated,
//        TileMode.mirror,

        0,
        pi/2,
      Float64List.fromList([
        1, 0, 0, 0,
        0, 2, 0, 0,
        0, 0, 1, 0,
        0, 0, 0, 1,
      ]),
    );
    canvas.drawCircle(Offset(0, 150), 150, _paint);
  }

  void _testImageShaderMatrix(Canvas canvas, Size size) {
    Paint _paint = Paint();
    _paint.isAntiAlias = true;
    _paint.shader = ImageShader(_src, TileMode.mirror,
//        TileMode.clamp,
      TileMode.repeated,
//        TileMode.mirror,
        Float64List.fromList([
          0.5, 0, 0, 0.001,
          0, 0.5, 0, 0,
          0, 0, 1, 0,
          0, 0, 0, 1,
        ]));

    canvas.drawCircle(Offset.zero, 200, _paint);
  }

  void _transformRotateY(Canvas canvas, Size size) {
    Path path = Path();
    path.lineTo(60, 60);
    path.lineTo(-60, 60);
    path.lineTo(60, -60);
    path.lineTo(-60, -160);
    path.close();
    canvas.drawPath(path, _paint);
    double angle = 1;
    // 绕y轴顺时针旋转
    Float64List matrix = Float64List.fromList(
        [
          cos(angle),   0,   sin(angle),      0,
          0,            1,            0,       0,
          -sin(angle),  0,   cos(angle),      0,
          0,            0,            0,       1
        ]);
    // 绕y轴逆时针旋转
    Float64List matrix1 = Float64List.fromList(
        [
          cos(angle),   0,  -sin(angle),      0,
          0,            1,            0,       0,
          sin(angle),   0,   cos(angle),      0,
          0,            0,            0,      1
        ]);
    canvas.transform(matrix);
//    canvas.rotate(pi/2);
    canvas.drawPath(
        path,
        _paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
  }

  void _transformRotateX(Canvas canvas, Size size) {
    Path path = Path();
    path.lineTo(60, 60);
    path.lineTo(-60, 60);
    path.lineTo(60, -60);
    path.lineTo(-60, -160);
    path.close();
    canvas.drawPath(path, _paint);
    double angle = pi/4;
    // 绕x轴顺时针旋转
    Float64List matrix = Float64List.fromList(
        [
          1,           0,          0,         0,
          0,  cos(angle),   sin(angle),       0,
          0, -sin(angle),   cos(angle),       0,
          0,           0,            0,       1
        ]);
    // 绕x轴逆时针旋转
    Float64List matrix1 = Float64List.fromList(
        [
        1,           0,          0,         0,
        0,  cos(angle),   -sin(angle),      0,
        0,  sin(angle),   cos(angle),       0,
        0,           0,            0,       1
        ]);
    canvas.transform(matrix);
//    canvas.rotate(pi/2);
    canvas.drawPath(
        path,
        _paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
  }

  void _transformRotateZ(Canvas canvas, Size size) {
    Path path = Path();
    path.lineTo(60, 60);
    path.lineTo(-60, 60);
    path.lineTo(60, -60);
    path.lineTo(-60, -160);
    path.close();
    canvas.drawPath(path, _paint);
    double angle = 0.5;
    // 绕z轴顺时针旋转
    Float64List matrix = Float64List.fromList(
        [
          cos(angle),   sin(angle),    0,   0,
          -sin(angle),   cos(angle),   0,   0,
          0,                    0,     1,   0,
          0,                    0,     0,   1
        ]);
    // 绕z轴逆时针旋转
    Float64List matrix1 = Float64List.fromList(
        [
          cos(angle),   -sin(angle),    0,   0,
          sin(angle),   cos(angle),   0,   0,
          0,                    0,     1,   0,
          0,                    0,     0,   1
        ]);
    canvas.transform(matrix);
//    canvas.rotate(pi/2);
    canvas.drawPath(
        path,
        _paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
  }

  void _transformScale(Canvas canvas, Size size) {
    Path path = Path();
    path.lineTo(60, 60);
    path.lineTo(-60, 60);
    path.lineTo(60, -60);
    path.lineTo(-60, -160);
    path.close();
    canvas.drawPath(path, _paint);
    Float64List matrix = Float64List.fromList(
        [
          2,   0,   0,   0,
          0,   1,   0,   0,
          0,   0,   1,   0,
          0,   0,   0,   1
        ]);
    canvas.transform(matrix);
    canvas.drawPath(
        path,
        _paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
  }

  void _transformTranslate(Canvas canvas, Size size) {
    Path path = Path();
    path.lineTo(60, 60);
    path.lineTo(-60, 60);
    path.lineTo(60, -60);
    path.lineTo(-60, -160);
    path.close();
    canvas.drawPath(path, _paint);
    Float64List matrix = Float64List.fromList(
        [
          1,   0,   0,   0,
          0,   1,   0,   0,
          0,   0,   1,   0,
          50,   50,   50,   1
        ]);
    canvas.transform(matrix);
    canvas.drawPath(
        path,
        _paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2);
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
