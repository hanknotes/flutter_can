import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_can/main/canvas_widgets/c02_spaceman/util/Canvas3DUtil.dart';
import 'package:flutter_can/main/canvas_widgets/c02_spaceman/util/Point3d.dart';

// 画长方体，并沿着x\y\z 或指定线旋转
class ThreeDPainter extends CustomPainter with Canvas3DUtil {
  Animation<double> animation;
  Point3d p3A, p3B, p3C, p3D, p3E, p3F, p3G, p3H;
  Point3d eye;
  Offset p2A, p2B, p2C, p2D, p2E, p2F, p2G, p2H;
  double rotateAngle = 0.02;

  ThreeDPainter(this.animation) : super(repaint: animation) {
    // 观察点
    eye = Point3d(x: 0, y: 0, z: 300);
    // 初始点
    p3A = Point3d(x: -50, y: 50, z: 50);
    p3B = Point3d(x: -50, y: 50, z: -50);
    p3C = Point3d(x: 50, y: 50, z: -50);
    p3D = Point3d(x: 50, y: 50, z: 50);
    p3E = Point3d(x: -50, y: -50, z: 50);
    p3F = Point3d(x: -50, y: -50, z: -50);
    p3G = Point3d(x: 50, y: -50, z: -50);
    p3H = Point3d(x: 50, y: -50, z: 50);
  }

  // 绕y轴旋转后的点
  void rotateY() {
    p3A = getRotateYPoint(rotateAngle, p3A);
    p3B = getRotateYPoint(rotateAngle, p3B);
    p3C = getRotateYPoint(rotateAngle, p3C);
    p3D = getRotateYPoint(rotateAngle, p3D);
    p3E = getRotateYPoint(rotateAngle, p3E);
    p3F = getRotateYPoint(rotateAngle, p3F);
    p3G = getRotateYPoint(rotateAngle, p3G);
    p3H = getRotateYPoint(rotateAngle, p3H);
  }

  // 绕y轴旋转后的点
  void rotateX() {
    p3A = getRotateXPoint(rotateAngle, p3A);
    p3B = getRotateXPoint(rotateAngle, p3B);
    p3C = getRotateXPoint(rotateAngle, p3C);
    p3D = getRotateXPoint(rotateAngle, p3D);
    p3E = getRotateXPoint(rotateAngle, p3E);
    p3F = getRotateXPoint(rotateAngle, p3F);
    p3G = getRotateXPoint(rotateAngle, p3G);
    p3H = getRotateXPoint(rotateAngle, p3H);
  }

  // 绕y轴旋转后的点
  void rotateZ() {
    p3A = getRotateZPoint(rotateAngle, p3A);
    p3B = getRotateZPoint(rotateAngle, p3B);
    p3C = getRotateZPoint(rotateAngle, p3C);
    p3D = getRotateZPoint(rotateAngle, p3D);
    p3E = getRotateZPoint(rotateAngle, p3E);
    p3F = getRotateZPoint(rotateAngle, p3F);
    p3G = getRotateZPoint(rotateAngle, p3G);
    p3H = getRotateZPoint(rotateAngle, p3H);
  }

  // 绕指定直线旋转后的点
  List<Point3d> rotateLine() {
    // 绕x轴
    // Point3d p1 = Point3d(x:0,y:0,z:0);
    // Point3d p2 = Point3d(x:-100,y:0,z:0);
    // 绕y轴
    // Point3d p1 = Point3d(x:0,y:0,z:0);
    // Point3d p2 = Point3d(x:0,y:100,z:0);
    // 绕z轴
    // Point3d p1 = Point3d(x:0,y:0,z:0);
    // Point3d p2 = Point3d(x:0,y:0,z:100);
    // 绕x轴
    Point3d p1 = Point3d(x:100,y:0,z:100);
    Point3d p2 = Point3d(x:10,y:100,z:200);

    p3A = getRotateLinePoint(rotateAngle, p3A,p1,p2);
    p3B = getRotateLinePoint(rotateAngle, p3B,p1,p2);
    p3C = getRotateLinePoint(rotateAngle, p3C,p1,p2);
    p3D = getRotateLinePoint(rotateAngle, p3D,p1,p2);
    p3E = getRotateLinePoint(rotateAngle, p3E,p1,p2);
    p3F = getRotateLinePoint(rotateAngle, p3F,p1,p2);
    p3G = getRotateLinePoint(rotateAngle, p3G,p1,p2);
    p3H = getRotateLinePoint(rotateAngle, p3H,p1,p2);

    return [p1,p2];
  }

// 投影到xy平面的点
  void projectionXY() {
    p2A = transform3DPointToXY(eye, p3A);
    p2B = transform3DPointToXY(eye, p3B);
    p2C = transform3DPointToXY(eye, p3C);
    p2D = transform3DPointToXY(eye, p3D);
    p2E = transform3DPointToXY(eye, p3E);
    p2F = transform3DPointToXY(eye, p3F);
    p2G = transform3DPointToXY(eye, p3G);
    p2H = transform3DPointToXY(eye, p3H);
  }

  @override
  void paint(Canvas canvas, Size size) {
    translateToCenter(canvas, size);
    drawXY(canvas, size);
    rotateY();
    // List<Point3d> list = rotateLine();
    // drawP12(list[0], list[1],canvas);
    projectionXY();
    drawRect3d(canvas, size);
  }

  // 画射线
  void drawP12(Point3d p1,Point3d p2,Canvas canvas){
    Paint paint = Paint();
    paint.color = Colors.grey;
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;
    Offset start = transform3DPointToXY(eye, p1);
    Offset end = transform3DPointToXY(eye, p2);
    canvas.drawLine(start, end, paint);
  }

  // 画长方体
  void drawRect3d(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.grey;
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;
    Path path = Path();

    path.moveTo(p2A.dx, p2A.dy);
    path.lineTo(p2B.dx, p2B.dy);
    path.lineTo(p2C.dx, p2C.dy);
    path.lineTo(p2D.dx, p2D.dy);
    path.lineTo(p2A.dx, p2A.dy);

    path.lineTo(p2E.dx, p2E.dy);
    path.lineTo(p2F.dx, p2F.dy);
    path.lineTo(p2G.dx, p2G.dy);
    path.lineTo(p2H.dx, p2H.dy);
    path.lineTo(p2E.dx, p2E.dy);

    path.moveTo(p2B.dx, p2B.dy);
    path.lineTo(p2F.dx, p2F.dy);

    path.moveTo(p2C.dx, p2C.dy);
    path.lineTo(p2G.dx, p2G.dy);

    path.moveTo(p2D.dx, p2D.dy);
    path.lineTo(p2H.dx, p2H.dy);

    canvas.drawPath(path, paint);
  }

  // 画xy坐标系
  void drawXY(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.grey;
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;
    canvas.drawLine(Offset.zero, Offset(200, 0), paint);
    canvas.drawLine(Offset.zero, Offset(0, 200), paint);
  }

  // 原点移到中心点
  void translateToCenter(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
