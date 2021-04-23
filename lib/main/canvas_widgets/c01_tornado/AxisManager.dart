import 'dart:math';
import 'package:flutter/material.dart';

// 龙卷风的中轴线，继承ChangeNotifier，是为了回调tick()方法，每一帧都调用
class AxisManager extends ChangeNotifier {
  Path path = Path();
  double x1 = -160;// x1  y1  贝塞尔曲线的第一个控制点
  double y1 = -70;
  bool isX1Right = true; // x1控制点在移动过程中的方向，通过控制点的移动让龙卷风扭曲
  double x2 = 160;
  double y2 = -200;
  bool isX2Right = true;
  double x3 = -190;
  double y3 = -400;
  bool isX3Right = true;

  double angle = 0; // 龙卷风最底部的点，设定为旋转移动，每一帧旋转的角度

  AxisManager(){
    path.moveTo(0, 0);
    path.relativeCubicTo(x1, y1, x2, y2, x3, y3);
  }

  void tick() {
   update();
    notifyListeners();
  }

  void update(){
    double dis = 2;// 每一帧，控制点移动的距离

    if(x1<=-160){
      isX1Right = true;
    }else if(x1>=160){
      isX1Right = false;
    }
    if(isX1Right){
      x1+=dis;
    }else{
      x1-=dis;
    }

    if(x2<=-160){
      isX2Right = true;
    }else if(x2>=160){
      isX2Right = false;
    }
    if(isX2Right){
      x2+=dis;
    }else{
      x2-=dis;
    }

    if(x3<=-190){
      isX3Right = true;
    }else if(x3>=190){
      isX3Right = false;
    }
    if(isX3Right){
      x3+=dis;
    }else{
      x3-=dis;
    }

    path.reset();
    angle-=0.02;
    if(angle<-pi*2){
      angle=0;
    }
    path.moveTo(150*sin(angle), x1/5);
    path.relativeCubicTo(x1, y1, x2, y2, x3, y3);
  }

  Path getAxis(){
    return path;
  }
}
