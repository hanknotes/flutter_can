import 'dart:ui';
import 'dart:math';

import 'Point3d.dart';

class Canvas3DUtil{


  // Point3d 绕x轴旋转角度后，返回新的Point3d   顺时针
  Point3d getRotateXPoint(double rotateAngle, Point3d src) {
    double ry = src.y * cos(rotateAngle) - src.z * sin(rotateAngle);
    double rz = src.z * cos(rotateAngle) + src.y * sin(rotateAngle);
    return Point3d(x: src.x, y: ry, z: rz);
  }

  // Point3d 绕y轴旋转角度后，返回新的Point3d  顺时针
  Point3d getRotateYPoint(double rotateAngle, Point3d src) {
    double rz = src.z * cos(rotateAngle) - src.x * sin(rotateAngle);
    double rx = src.x * cos(rotateAngle) + src.z * sin(rotateAngle);
    return Point3d(x: rx, y: src.y, z: rz);
  }

  // Point3d 绕z轴旋转角度后，返回新的Point3d   顺时针
  Point3d getRotateZPoint(double rotateAngle, Point3d src) {
    double rx = src.x * cos(rotateAngle) - src.y * sin(rotateAngle);
    double ry = src.y * cos(rotateAngle) + src.x * sin(rotateAngle);
    return Point3d(x: rx, y: ry, z: src.z);
  }

  // Point3d 绕空间直线轴旋转角度后，返回新的Point3d   顺时针  直线由p1和p2两个空间点确定
  Point3d getRotateLinePoint(double angle, Point3d p, Point3d p1, Point3d p2) {
    //计算两点之间距离
    double distance = getDistanceBetweenTwoPoints(p1, p2);
    // 计算p1 -> p2 的矢量
    double u = (p1.x - p2.x) / distance;
    double v = (p1.y - p2.y) / distance;
    double w = (p1.z - p2.z) / distance;

    double SinA = sin(angle);
    double CosA = cos(angle);

    double uu = u * u;
    double vv = v * v;
    double ww = w * w;
    double uv = u * v;
    double uw = u * w;
    double vw = v * w;

    double t00 = uu + (vv + ww) * CosA;
    double t10 = uv * (1 - CosA) + w * SinA;
    double t20 = uw * (1 - CosA) - v * SinA;

    double t01 = uv * (1 - CosA) - w * SinA;
    double t11 = vv + (uu + ww) * CosA;
    double t21 = vw * (1 - CosA) + u * SinA;

    double t02 = uw * (1 - CosA) + v * SinA;
    double t12 = vw * (1 - CosA) - u * SinA;
    double t22 = ww + (uu + vv) * CosA;

    double a0 = p2.x;
    double b0 = p2.y;
    double c0 = p2.z;

    double t03 = (a0 * (vv + ww) - u * (b0 * v + c0 * w)) * (1 - CosA) +
        (b0 * w - c0 * v) * SinA;
    double t13 = (b0 * (uu + ww) - v * (a0 * u + c0 * w)) * (1 - CosA) +
        (c0 * u - a0 * w) * SinA;
    double t23 = (c0 * (uu + vv) - w * (a0 * u + b0 * v)) * (1 - CosA) +
        (a0 * v - b0 * u) * SinA;

    return Point3d(
        x: t00 * p.x + t01 * p.y + t02 * p.z + t03,
        y: t10 * p.x + t11 * p.y + t12 * p.z + t13,
        z: t20 * p.x + t21 * p.y + t22 * p.z + t23);
  }

  // 从给定点将3d坐标投影到xy平面后的坐标，从eye看eyedPoint，映射在xy平面的坐标
  Offset transform3DPointToXY(Point3d eye, Point3d eyedPoint,
      {double offsetX = 0, double offsetY = 0}) {
    return Offset(
        (eyedPoint.x - eye.x) * eye.z / (eye.z - eyedPoint.z) + offsetX,
        (eyedPoint.y - eye.y) * eye.z / (eye.z - eyedPoint.z) + offsetY);
  }

  // 求空间两点之间距离
  double getDistanceBetweenTwoPoints(Point3d a, Point3d b) {
    return sqrt(pow(a.x - b.x, 2) + pow(a.y - b.y, 2) + pow(a.z - b.z, 2));
  }


  // 点p1和p2组成一条直线，求空间点point到该直线的距离，就是点到直线的距离
  double getLengthOfSrcToStartEnd(Point3d point, Point3d p1, Point3d p2) {
    // 三个点，组成一个三角形，先求三条边长
    double a = getDistanceBetweenTwoPoints(point, p1);
    double b = getDistanceBetweenTwoPoints(point, p2);
    double c = getDistanceBetweenTwoPoints(p1, p2);
    double s = (a + b + c) / 2;
    double area = sqrt(s * (s - a) * (s - b) * (s - c));
    return area * 2 / c;
  }
}