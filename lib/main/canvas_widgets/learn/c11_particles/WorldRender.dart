import 'package:flutter/material.dart';

import 'Particle.dart';
import 'ParticleManange.dart';

class WorldRender extends CustomPainter {
  final ParticleManage manage;

  Paint fillPaint = Paint();

  Paint stokePaint = Paint()
    ..strokeWidth = 0.5
    ..color = Colors.red
    ..style = PaintingStyle.stroke;

  WorldRender({this.manage}) : super(repaint: manage);

  @override
  void paint(Canvas canvas, Size size) {
    // print("size="+size.width.toString()+" "+size.height.toString());
    canvas.translate(size.width / 2 - manage.size.width / 2,
        size.height / 2 - manage.size.height / 2);
    canvas.drawRect(Offset.zero & manage.size, stokePaint);
    manage.particles.forEach((particle) {
      drawParticle(canvas, particle);
    });
  }

  void drawParticle(Canvas canvas, Particle particle) {
    fillPaint.color = particle.color;
    canvas.drawCircle(Offset(particle.x, particle.y), particle.size, fillPaint);
  }

  @override
  bool shouldRepaint(covariant WorldRender oldDelegate) =>
      oldDelegate.manage != manage;
}
