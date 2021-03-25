import 'dart:ui';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_can/c13_tornado/AxisManager.dart';
import 'package:flutter_can/c13_tornado/Particle.dart';

import 'ParticleManager.dart';

class TornadoRender extends CustomPainter{

  ParticleManager pm;

  TornadoRender(this.pm): super(repaint: pm);

  Paint _windPaint = Paint()
  ..color = Colors.grey
  ..style = PaintingStyle.fill
  ..isAntiAlias = true;

  @override
  void paint(Canvas canvas, Size size) {
    translateToCenter(canvas, size);
    drawAxis(canvas, size);
    drawParticles(canvas, size);
  }

  void drawAxis(Canvas canvas, Size size){
    canvas.drawPath(pm.am.getAxis(), Paint() ..color=Colors.grey ..style=PaintingStyle.stroke ..strokeWidth=1);
  }

  void drawParticles(Canvas canvas, Size size){

    int size = pm.list.length;
    for(int i=0;i<size;i++){
      Particle particle =  pm.list[i];
      canvas.save();
      canvas.translate(particle.center.dx, particle.center.dy);
      // canvas.rotate(-particle.angle+pi/2);
      canvas.drawCircle(Offset(particle.x,particle.y), 2, _windPaint);
      canvas.restore();
    }
  }

  void translateToCenter(Canvas canvas, Size size){
    canvas.translate(size.width/2, size.height-150);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}