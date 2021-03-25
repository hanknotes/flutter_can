import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_can/c13_tornado/AxisManager.dart';
import 'package:flutter_can/c13_tornado/Particle.dart';

class ParticleManager extends ChangeNotifier {
  AxisManager am;

  ParticleManager(this.am);

  List<Particle> list = [];

  void add(Particle p) {
    if (p != null) {
      list.add(p);
      notifyListeners();
    }
  }

  void tick() {
    Random random = Random();

    list.forEach((p) {
      doUpdate(p,random);
    });
    notifyListeners();
  }

  // 龙卷风
  void doUpdate(Particle p,Random random) {
    Path axis = am.getAxis();
    PathMetric pathMetric = axis.computeMetrics().first;
    p.cur += p.curStep;
    if(p.cur>pathMetric.length){
      p.cur = 0;
    }
    Tangent tg = pathMetric.getTangentForOffset(p.cur);
    double angle = tg.angle;
    p.angle = angle;
    Offset center = tg.position;
    p.center = center;
    p.radius = p.cur/5;

    p.rotate += 0.01;
    if(p.rotate>1){
      p.rotate=0;
    }
    p.x = p.radius * sin(pi * 2 *p.rotate  + p.initRotate);
  }


  // 蛇形上旋
  void doUpdate1(Particle p,Random random) {
    Path axis = am.getAxis();
    PathMetric pathMetric = axis.computeMetrics().first;
    p.cur += 2;
    if(p.cur>pathMetric.length){
      p.cur = 0;
    }
    Tangent tg = pathMetric.getTangentForOffset(p.cur);
    double angle = tg.angle;
    p.angle = angle;
    Offset center = tg.position;
    p.center = center;
    p.radius = 100;

    p.rotate += 0.01;
    if(p.rotate>1){
      p.rotate=0;
    }
    p.x = p.radius * sin(pi * 2 *p.rotate  + p.initRotate);
  }

  // 漏斗形上旋
  void doUpdate3(Particle p,Random random) {
    p.y += p.vy;
    if (p.y < -500) {
      p.y = 0;
    }
    p.radius = 100 - p.y / 4;
    p.rotate += 0.01;
    if(p.rotate>1){
      p.rotate=0;
    }
    p.x = p.radius * sin(pi * 2 *p.rotate  + p.initRotate);
  }

}
