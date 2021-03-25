import 'dart:math';
import 'dart:ui';

import 'package:flutter_can/c14_3d/util/Canvas3DUtil.dart';
import 'package:flutter_can/c14_3d/util/Point3d.dart';

class Cuboid with Canvas3DUtil {
  double x, y, z, long, width, height;
  Point3d p3A, p3B, p3C, p3D, p3E, p3F, p3G, p3H;
  Point3d eye;
  Offset p2A, p2B, p2C, p2D, p2E, p2F, p2G, p2H;
  Cuboid(
      {this.x = 0,
      this.y = 0,
      this.z = 0,
      this.long = 50,
      this.width = 50,
      this.height = 10}) {
    p3A = Point3d(x: x - width / 2, y: y - long / 2, z: z + height / 2);
    p3E = Point3d(x: x - width / 2, y: y - long / 2, z: z - height / 2);
    p3B = Point3d(x: x + width / 2, y: y - long / 2, z: z + height / 2);
    p3F = Point3d(x: x + width / 2, y: y - long / 2, z: z - height / 2);
    p3C = Point3d(x: x + width / 2, y: y + long / 2, z: z + height / 2);
    p3G = Point3d(x: x + width / 2, y: y + long / 2, z: z - height / 2);
    p3D = Point3d(x: x - width / 2, y: y + long / 2, z: z + height / 2);
    p3H = Point3d(x: x - width / 2, y: y + long / 2, z: z - height / 2);

    eye = Point3d(x: 0, y: 0, z: 300);

    // rotateX();
    // rotateY();
    // rotateZ();
  }

  rotateX() {
    double rotateAngle = pi / 4;
    p3A = getRotateXPoint(rotateAngle, p3A);
    p3B = getRotateXPoint(rotateAngle, p3B);
    p3C = getRotateXPoint(rotateAngle, p3C);
    p3D = getRotateXPoint(rotateAngle, p3D);
    p3E = getRotateXPoint(rotateAngle, p3E);
    p3F = getRotateXPoint(rotateAngle, p3F);
    p3G = getRotateXPoint(rotateAngle, p3G);
    p3H = getRotateXPoint(rotateAngle, p3H);
  }

  rotateY({double rotateAngle = pi * 5 / 8}) {
    p3A = getRotateYPoint(rotateAngle, p3A);
    p3B = getRotateYPoint(rotateAngle, p3B);
    p3C = getRotateYPoint(rotateAngle, p3C);
    p3D = getRotateYPoint(rotateAngle, p3D);
    p3E = getRotateYPoint(rotateAngle, p3E);
    p3F = getRotateYPoint(rotateAngle, p3F);
    p3G = getRotateYPoint(rotateAngle, p3G);
    p3H = getRotateYPoint(rotateAngle, p3H);
  }

  rotateZ() {
    double rotateAngle = pi * 7 / 8;
    p3A = getRotateZPoint(rotateAngle, p3A);
    p3B = getRotateZPoint(rotateAngle, p3B);
    p3C = getRotateZPoint(rotateAngle, p3C);
    p3D = getRotateZPoint(rotateAngle, p3D);
    p3E = getRotateZPoint(rotateAngle, p3E);
    p3F = getRotateZPoint(rotateAngle, p3F);
    p3G = getRotateZPoint(rotateAngle, p3G);
    p3H = getRotateZPoint(rotateAngle, p3H);
  }

  void rotateLine(double rotateAngle) {
    // 绕x轴
    // Point3d p1 = Point3d(x:0,y:0,z:0);
    // Point3d p2 = Point3d(x:-100,y:0,z:0);
    // 绕y轴
    // Point3d p1 = Point3d(x:0,y:0,z:0);
    // Point3d p2 = Point3d(x:0,y:100,z:0);
    // 绕z轴
    // Point3d p1 = Point3d(x:0,y:0,z:0);
    // Point3d p2 = Point3d(x:0,y:0,z:100);
    // 绕西北东南轴
    Point3d p1 = Point3d(x: 100, y: 100, z: 100);
    Point3d p2 = Point3d(x: -100, y: -100, z: -100);

    p3A = getRotateLinePoint(rotateAngle, p3A, p1, p2);
    p3B = getRotateLinePoint(rotateAngle, p3B, p1, p2);
    p3C = getRotateLinePoint(rotateAngle, p3C, p1, p2);
    p3D = getRotateLinePoint(rotateAngle, p3D, p1, p2);
    p3E = getRotateLinePoint(rotateAngle, p3E, p1, p2);
    p3F = getRotateLinePoint(rotateAngle, p3F, p1, p2);
    p3G = getRotateLinePoint(rotateAngle, p3G, p1, p2);
    p3H = getRotateLinePoint(rotateAngle, p3H, p1, p2);
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

  Path getPath(double rotateAngle) {
    rotateY(rotateAngle: rotateAngle);
    projectionXY();
    Path path1 = Path()
      // ABCD
      ..moveTo(p2A.dx, p2A.dy)
      ..lineTo(p2B.dx, p2B.dy)
      ..lineTo(p2C.dx, p2C.dy)
      ..lineTo(p2D.dx, p2D.dy)
      ..lineTo(p2A.dx, p2A.dy);

    //AEDH
    Path path2 = Path()
      ..moveTo(p2A.dx, p2A.dy)
      ..lineTo(p2D.dx, p2D.dy)
      ..lineTo(p2H.dx, p2H.dy)
      ..lineTo(p2E.dx, p2E.dy)
      ..lineTo(p2A.dx, p2A.dy);

    // ABEF
    Path path3 = Path()
      ..moveTo(p2A.dx, p2A.dy)
      ..lineTo(p2B.dx, p2B.dy)
      ..lineTo(p2F.dx, p2F.dy)
      ..lineTo(p2E.dx, p2E.dy)
      ..lineTo(p2A.dx, p2A.dy);

    // GCDH
    Path path4 = Path()
      ..moveTo(p2G.dx, p2G.dy)
      ..lineTo(p2C.dx, p2C.dy)
      ..lineTo(p2D.dx, p2D.dy)
      ..lineTo(p2H.dx, p2H.dy)
      ..lineTo(p2G.dx, p2G.dy);

    // GCBF
    Path path5 = Path()
      ..moveTo(p2G.dx, p2G.dy)
      ..lineTo(p2C.dx, p2C.dy)
      ..lineTo(p2B.dx, p2B.dy)
      ..lineTo(p2F.dx, p2F.dy)
      ..lineTo(p2G.dx, p2G.dy);

    // GFEH
    Path path6 = Path()
      ..moveTo(p2G.dx, p2G.dy)
      ..lineTo(p2F.dx, p2F.dy)
      ..lineTo(p2E.dx, p2E.dy)
      ..lineTo(p2H.dx, p2H.dy)
      ..lineTo(p2G.dx, p2G.dy);

    Path path = Path();
    path.addPath(path1, Offset.zero);
    path.addPath(path2, Offset.zero);
    path.addPath(path3, Offset.zero);
    path.addPath(path4, Offset.zero);
    path.addPath(path5, Offset.zero);
    path.addPath(path6, Offset.zero);
    return path;
  }
}
