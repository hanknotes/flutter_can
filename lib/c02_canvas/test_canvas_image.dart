import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:ui';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class TestCanvasImage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<TestCanvasImage> {
  ui.Image _image;
  ui.Image _atlas;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void _loadImage() async {
    _image = await loadImageFromAssets('images/a2.png');
    _atlas = await loadImageFromAssets('images/b.jpg');
    setState(() {});
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
        painter: _MyPaint(_image, _atlas),
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
  ui.Image image;
  ui.Image _atlas;
  Paint _paint;
  final double strokeWidth = 0.5;
  final Color color = Colors.blue;

  _MyPaint(this.image, this._atlas) {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;
  }
  @override
  void paint(Canvas canvas, Size size) {
    translateToCenter(canvas, size);
    _drawRawAtlas(canvas);
  }

  void _drawAtlas(Canvas canvas) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    Rect cullRect = Rect.fromLTRB(50, 50, 50, 50);
    canvas.drawAtlas(
        image,
        [
          RSTransform.fromComponents(
              rotation: -10,
              scale: 1.0,
              anchorX: 0,
              anchorY: 0,
              translateX: 10,
              translateY: 10),
          RSTransform.fromComponents(
              rotation: 40,
              scale: 1.0,
              anchorX: 0,
              anchorY: 0,
              translateX: 90,
              translateY: 90)
        ],
        [Rect.fromLTWH(50, 50, 100, 100), Rect.fromLTWH(150, 150, 100, 100)],
        [Colors.redAccent, Colors.blueAccent],
        BlendMode.srcIn,
        cullRect,
        paint);
  }

  void _drawRawAtlas(Canvas canvas) {
    List<Sprite> allSprites = [];
    allSprites.add(Sprite(
        position: Rect.fromLTWH(0, 200, 100, 200),
        offset: Offset(0, 0),
        alpha: 255,
        rotation: 0));

    allSprites.add(Sprite(
        position: Rect.fromLTWH(0, 325, 257, 166),
        offset: Offset(100, 100),
        alpha: 255,
        rotation: 0));

    Float32List rectList = Float32List(allSprites.length * 4);
    Float32List transformList = Float32List(allSprites.length * 4);

    for (int i = 0; i < allSprites.length; i++) {
      final Sprite sprite = allSprites[i];
      rectList[i * 4 + 0] = sprite.position.left;
      rectList[i * 4 + 1] = sprite.position.top;
      rectList[i * 4 + 2] = sprite.position.right;
      rectList[i * 4 + 3] = sprite.position.bottom;
      final RSTransform transform = RSTransform.fromComponents(
        rotation: sprite.rotation,
        scale: 1.0,
        anchorX: 10,
        anchorY: 10,
        translateX: sprite.offset.dx,
        translateY: sprite.offset.dy,
      );
      transformList[i * 4 + 0] = transform.ssin;
      transformList[i * 4 + 1] = transform.scos;
      transformList[i * 4 + 2] = transform.tx;
      transformList[i * 4 + 3] = transform.ty;
    }
    canvas.drawRawAtlas(image, transformList, rectList, null, null, null, _paint);
  }

  void _drawxxx(Canvas canvas, Size size) {
    Paint paint = new Paint();
    paint
      ..color = Colors.redAccent[200]
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;
  }

  void _drawTextPaintWithPaint(Canvas canvas) {
    Paint textPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: 'Flutter Can',
            style: TextStyle(foreground: textPaint, fontSize: 40)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textPainter.layout(maxWidth: 280); // 进行布局
    Size size = textPainter.size; // 尺寸必须在布局后获取
    textPainter.paint(canvas, Offset(-size.width / 2, -size.height / 2));

    canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width, size.height)
            .translate(-size.width / 2, -size.height / 2),
        _paint..color = Colors.blue.withAlpha(33));
  }

  void _drawTextPaint(Canvas canvas) {
    var textpainter = TextPainter(
        text: TextSpan(
            text: '123456', style: TextStyle(fontSize: 40, color: Colors.red)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    textpainter.layout();
    Size size = textpainter.size;
    textpainter.paint(canvas, Offset(-size.width / 2, -size.height / 2));
  }

  void _drawTextWithParagraph(Canvas canvas) {
    TextAlign textAlign = TextAlign.center;
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: textAlign,
      fontSize: 40,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    ));
    var builder1 = ui.ParagraphBuilder(ui.ParagraphStyle(
        textAlign: TextAlign.right,
        fontSize: 40,
        textDirection: TextDirection.ltr,
        maxLines: 1));
    builder.pushStyle(
      ui.TextStyle(
          color: Colors.black87, textBaseline: ui.TextBaseline.alphabetic),
    );
    builder1.pushStyle(ui.TextStyle(
        color: Colors.red, textBaseline: ui.TextBaseline.alphabetic));

    builder.addText("Flutter Can");
    builder1.addText("ssssssss");
    ui.Paragraph paragraph = builder.build();
    ui.Paragraph paragraph1 = builder1.build();

    paragraph.layout(ui.ParagraphConstraints(width: 300));
    paragraph1.layout(ui.ParagraphConstraints(width: 400));

    canvas.drawParagraph(paragraph, Offset(-100, 0));
    canvas.drawParagraph(paragraph1, Offset(-200, -110));

    canvas.drawRect(Rect.fromLTRB(0, 0, 300, 40),
        _paint..color = Colors.blue.withAlpha(33));
  }

  void _drawImageNine(Canvas canvas) {
    if (image != null) {
      print("........" + image.width.toString() + image.height.toString());
      canvas.drawImageNine(
          image,
          Rect.fromCenter(
              center: Offset(image.width / 2, image.height - 150.0),
              width: 1,
              height: 1.0),
          Rect.fromCenter(
              center: Offset(
                0,
                0,
              ),
              width: 430,
              height: 430),
          _paint);

//      canvas.drawImageNine(
//          image,
//          Rect.fromCenter(
//              center: Offset(image.width / 2, image.height - 6.0),
//              width: image.width - 20.0,
//              height: 2.0),
//          Rect.fromCenter(
//                  center: Offset(
//                    0,
//                    0,
//                  ),
//                  width: 100,
//                  height: 50)
//              .translate(250, 0),
//          _paint);
//
//      canvas.drawImageNine(
//          image,
//          Rect.fromCenter(
//              center: Offset(image.width / 2, image.height - 6.0),
//              width: image.width - 20.0,
//              height: 2.0),
//          Rect.fromCenter(
//                  center: Offset(
//                    0,
//                    0,
//                  ),
//                  width: 80,
//                  height: 250)
//              .translate(-250, 0),
//          _paint);
    }
  }

  void _drawImageRect(Canvas canvas) {
    if (image != null) {
      canvas.drawImageRect(
          image,
          Rect.fromCenter(
              center: Offset(image.width / 2, image.height / 2),
              width: 180,
              height: 180),
          Rect.fromLTRB(0, 0, 200, 200),
          _paint);

//      canvas.drawImageRect(
//          image,
//          Rect.fromCenter(
//              center: Offset(image.width / 2, image.height / 2 - 60),
//              width: 160,
//              height: 160),
//          Rect.fromLTRB(0, 0, 100, 100).translate(-280, -100),
//          _paint);
//
//      canvas.drawImageRect(
//          image,
//          Rect.fromCenter(
//              center: Offset(image.width / 2 + 60, image.height / 2),
//              width: 60,
//              height: 60),
//          Rect.fromLTRB(0, 0, 100, 100).translate(-280, 50),
//          _paint);
    }
  }

  void _drawImage(Canvas canvas) {
    if (image != null) {
      canvas.drawImage(
          image, Offset(-image.width / 2, -image.height / 2), _paint);
    }
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

class Sprite {
  Rect position; // 雪碧图 中 图片矩形区域
  Offset offset; // 移动偏倚
  int alpha; // 透明度
  double rotation; // 旋转角度
  Sprite({this.offset, this.alpha, this.rotation, this.position});
}
