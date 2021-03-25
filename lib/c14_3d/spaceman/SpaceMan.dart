import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_can/c14_3d/util/Canvas3DUtil.dart';
import 'package:flutter_can/c14_3d/util/Point3d.dart';
import 'package:flutter_can/c14_3d/spaceman/Cuboid.dart';

// 太空人
class SpaceMan extends CustomPainter with Canvas3DUtil {
  Animation<double> animation;
  double rotateAngle = 0.06;
  Cuboid _body,_head,_leftArm,_rightArm,_leftLeg,_rightLeg,_leftEye,_rightEye,_leftFoot,_rightFoot;


  SpaceMan(this.animation) : super(repaint: animation) {
    _body = Cuboid(long:100,width: 100,height: 40);
    _head = Cuboid(x:0,y:-80,long:60,width: 60,height: 40);
    _leftArm = Cuboid(x:-60,y:-80,z:0,long:120,width: 20,height: 20);
    _rightArm = Cuboid(x:60,y:-80,z:0,long:120,width: 20,height: 20);
    _leftLeg = Cuboid(x:-25,y:110,z:0,long:120,width: 30,height: 20);
    _rightLeg = Cuboid(x:25,y:110,z:0,long:120,width: 30,height: 20);
    _leftEye = Cuboid(x:-10,y:-90,z:15,long:10,width: 10,height: 10);
    _rightEye = Cuboid(x:10,y:-90,z:15,long:10,width: 10,height: 10);
    _leftFoot = Cuboid(x:-25,y:180,z:10,long:20,width: 30,height: 40);
    _rightFoot = Cuboid(x:25,y:180,z:10,long:20,width: 30,height: 40);
  }


  @override
  void paint(Canvas canvas, Size size) {
    translateToCenter(canvas, size);
    // drawXY(canvas, size);
    canvas.save();
    canvas.rotate(-pi/4);
    drawRect3d(canvas, size);
    drawWind(canvas);
    canvas.restore();
  }

  void drawWind(Canvas canvas){
    Paint paint = Paint();
    paint.color = Colors.grey;
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;
    canvas.drawLine(Offset(100,-150+800*animation.value), Offset(100,-100+800*animation.value), paint);
    canvas.drawLine(Offset(120,-300+1700*animation.value), Offset(120,-250+1700*animation.value), paint);
    canvas.drawLine(Offset(-110,-450+900*animation.value), Offset(-110,-400+900*animation.value), paint);
  }

  // 画长方体
  void drawRect3d(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = Colors.grey;
    paint.strokeWidth = 1;
    paint.style = PaintingStyle.stroke;
    Path path = Path();
    path.addPath(_body.getPath(rotateAngle), Offset.zero);
    path.addPath(_head.getPath(rotateAngle), Offset.zero);
    path.addPath(_leftArm.getPath(rotateAngle), Offset.zero);
    path.addPath(_rightArm.getPath(rotateAngle), Offset.zero);
    path.addPath(_leftLeg.getPath(rotateAngle), Offset.zero);
    path.addPath(_rightLeg.getPath(rotateAngle), Offset.zero);
    path.addPath(_leftEye.getPath(rotateAngle), Offset.zero);
    path.addPath(_rightEye.getPath(rotateAngle), Offset.zero);
    path.addPath(_leftFoot.getPath(rotateAngle), Offset.zero);
    path.addPath(_rightFoot.getPath(rotateAngle), Offset.zero);

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
