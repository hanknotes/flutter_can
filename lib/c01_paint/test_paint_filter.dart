import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class TestPaintFilter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestPaintState();
  }
}

class TestPaintState extends State<TestPaintFilter> {
  ui.Image _image;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    _image = await loadImageFromAssets('images/a2.png');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test paint"),
      ),
      body: CustomPaint(
        painter: _MyPaint(_image),
        size: Size(380, 560),
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
  ui.Image _image;
  _MyPaint(this._image);
  @override
  void paint(Canvas canvas, Size size) {
    translateToCenter(canvas, size);
    _testFilterQuality(canvas, size);
  }

  void _testColorFilter(Canvas canvas, Size size) {
    Paint _paint = Paint()
//      ..colorFilter = ColorFilter.mode(Colors.yellow, BlendMode.exclusion)
        ;
    canvas.drawImage(
        _image, Offset(-size.width / 2 + 10, -size.height / 2 + 10), _paint);
  }

  void _testImageFilter(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..imageFilter = ImageFilter.blur(sigmaX: 5, sigmaY: 5);
    canvas.drawImage(
        _image, Offset(-size.width / 2 + 10, -size.height / 2 + 10), _paint);
  }

  void _testMaskFilter(Canvas canvas, Size size) {
    Paint _paint = Paint()
//      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20);
//      ..maskFilter = MaskFilter.blur(BlurStyle.inner, 20);
//    ..maskFilter = MaskFilter.blur(BlurStyle.outer, 20);
      ..maskFilter = MaskFilter.blur(BlurStyle.solid, 20);
    canvas.drawImage(
        _image, Offset(-size.width / 2 + 10, -size.height / 2 + 10), _paint);
  }

  void _testFilterQuality(Canvas canvas, Size size) {
    Paint _paint = Paint()
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20)
      ..colorFilter = ColorFilter.mode(Colors.yellow, BlendMode.exclusion)
      ..imageFilter = ImageFilter.blur(sigmaX: 5, sigmaY: 5)
      ..filterQuality = FilterQuality.high;
//    ..filterQuality = FilterQuality.medium;
//    ..filterQuality = FilterQuality.low;
//      ..filterQuality = FilterQuality.none;
    canvas.drawImage(
        _image, Offset(-size.width / 2 + 10, -size.height / 2 + 10), _paint);
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
