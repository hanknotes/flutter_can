import 'package:flutter/material.dart';

class C15CustomPaint extends StatefulWidget {
  @override
  _C15CustomPaintState createState() => _C15CustomPaintState();
}

class _C15CustomPaintState extends State<C15CustomPaint>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller =
        new AnimationController(vsync: this, duration: Duration(seconds: 2));
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        width: 400,
        height: 400,
        child: CustomPaint(
          size: Size(300, 300),
          painter: BgPainter(_controller),
          foregroundPainter: ForePainter(),
          child: Center(
            child: SizedBox(
              child: Text("aaaaaaaaaaa"),
              width: 300,
              height: 300,
            ),
          ),
        ),
      ),
    );
  }
}

class BgPainter extends CustomPainter {
  Animation<double> animation;
  @override
  void paint(Canvas canvas, Size size) {
    print("==" + size.width.toString());
    Paint paint = Paint()
      ..color = Colors.blueAccent
      ..isAntiAlias = true;
    // canvas.drawPaint(paint);
    Rect rect = Rect.fromCenter(
        center: Offset(100, 200),
        width: 200 * animation.value,
        height: 200 * animation.value);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    print("shouldRepaint");
    return true;
  }

  BgPainter(this.animation) : super(repaint: animation) {
    print("BgPainter");
  }
}

class ForePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Rect rect =
        Rect.fromCenter(center: Offset(300, 200), width: 200, height: 200);
    Paint paint = Paint()
      ..color = Colors.greenAccent
      ..style = PaintingStyle.fill;
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
