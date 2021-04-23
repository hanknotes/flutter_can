import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class TestPaintBlendMode extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TestPaintState();
  }
}

class TestPaintState extends State<TestPaintBlendMode> {
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
        title: Text("test paint"),
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
//    translateToCenter(canvas, size);
    print("size=" + size.width.toString() + " " + size.height.toString());
    _test(canvas, size);
  }

  void _test(Canvas canvas, Size size) {
    Paint _paint = Paint();
    _paint.isAntiAlias = true;
    canvas.drawPaint(_paint..color = Colors.black12);// 画背景

    _paint.color = Colors.red;
    canvas.drawCircle(Offset(150, 100), 100, _paint); // 画红圆

    canvas.saveLayer(Offset.zero & size, Paint()); // 新建层

    _paint.color = Colors.yellowAccent;
    canvas.drawCircle(Offset(250, 100), 100, _paint); // 画黄圆

    canvas.drawImage(_dst, Offset(0,550), _paint); // 画底部绿色图

//    _paint.blendMode = BlendMode.clear;
//    _paint.blendMode = BlendMode.src;
//    _paint.blendMode = BlendMode.dst;
//    _paint.blendMode = BlendMode.srcOver;
//    _paint.blendMode = BlendMode.dstOver;
//    _paint.blendMode = BlendMode.srcIn;
//    _paint.blendMode = BlendMode.dstIn;
//    _paint.blendMode = BlendMode.srcOut;
//    _paint.blendMode = BlendMode.dstOut;
//    _paint.blendMode = BlendMode.srcATop;
//    _paint.blendMode = BlendMode.dstATop;
//    _paint.blendMode = BlendMode.xor;
//    _paint.blendMode = BlendMode.plus;
//    _paint.blendMode = BlendMode.modulate;
//    _paint.blendMode = BlendMode.screen;
//    _paint.blendMode = BlendMode.overlay;
//    _paint.blendMode = BlendMode.darken;
//    _paint.blendMode = BlendMode.lighten;
//    _paint.blendMode = BlendMode.colorDodge;
//    _paint.blendMode = BlendMode.colorBurn;
//    _paint.blendMode = BlendMode.hardLight;
//    _paint.blendMode = BlendMode.softLight;
//    _paint.blendMode = BlendMode.difference;
//    _paint.blendMode = BlendMode.exclusion;
//    _paint.blendMode = BlendMode.multiply;
//    _paint.blendMode = BlendMode.hue;
//    _paint.blendMode = BlendMode.saturation;
//    _paint.blendMode = BlendMode.color;
//    _paint.blendMode = BlendMode.luminosity;

    _paint.color = Colors.blueAccent;
    canvas.drawCircle(Offset(250, 250), 100, _paint);  // 画蓝圆
    _paint.color = Colors.green;
    canvas.drawCircle(Offset(150, 250), 100, _paint); // 画绿圆

    canvas.drawImage(_src, Offset(0,400), _paint); // 画儿童图

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
