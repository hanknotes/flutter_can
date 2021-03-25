import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class TestPaintShader extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestPaintState();
  }
}

class TestPaintState extends State<TestPaintShader> {
  ui.Image _src;
  ui.Image _dst;
  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    _src = await loadImageFromAssets('images/a2.png');
    _dst = await loadImageFromAssets('images/dst.jpeg');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test paint shader"),
      ),
      body: CustomPaint(
        painter: _MyPaint(_src, _dst),
        size: MediaQuery.of(context).size,
      ),
      backgroundColor: Colors.white,
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
  ui.Image _src;
  ui.Image _dst;
  _MyPaint(this._src, this._dst);
  @override
  void paint(Canvas canvas, Size size) {
    translateToCenter(canvas, size);
    print("size=" + size.width.toString() + " " + size.height.toString());
    _testGradientLinear(canvas, size);
  }


  void _testImageShader(Canvas canvas, Size size) {
    Paint _paint = Paint();
    _paint.isAntiAlias = true;
    _paint.shader = ImageShader(_src, TileMode.mirror,
        TileMode.mirror,
//      TileMode.repeated,
//        TileMode.mirror,
        Float64List.fromList([
      1, 0, 0, 0,
      0, 1, 0, 0,
      0, 0, 1, 0,
      0, 0, 0, 1,
    ]));

    canvas.drawCircle(Offset.zero, 200, _paint);
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
  }

  void _testGradientRadial(Canvas canvas, Size size) {
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
    );
    canvas.drawCircle(Offset(0, 0), 200, _paint);
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
      Offset(0, 0),
      [Colors.red, Colors.blue, Colors.green],
      [0.3, 0.5, 1],
//      TileMode.clamp,
//      TileMode.repeated,
      TileMode.mirror,
      0,
      pi/2
    );
    canvas.drawCircle(Offset(0, 0), 200, _paint);
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
