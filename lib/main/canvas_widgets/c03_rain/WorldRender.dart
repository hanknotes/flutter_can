import 'package:flutter/material.dart';
import 'dart:math';
import 'Particle.dart';
import 'ParticleManange.dart';

class WorldRender extends CustomPainter {
  final ParticleManage manage;

  Paint fillPaint = Paint()
    ..colorFilter = ColorFilter.matrix(<double>[
      1, 0, 0, 0, 0,
      0, 1, 0, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 0, 0.3, 0,
    ]);

  Paint stokePaint = Paint()
    ..strokeWidth = 0.5
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
    if(manage.image!=null){
      fillPaint.color = particle.color;
      canvas.save();
      canvas.translate(particle.x, particle.y);
      var dis = sqrt(particle.vy * particle.vy + particle.vx * particle.vx);
      canvas.rotate(acos(particle.vx / dis) + pi + pi / 2);
      canvas.drawImageRect(
          manage.image,
          Rect.fromLTWH(  0, 0, manage.image.width * 1.0, manage.image.height * 1.0),
          Rect.fromLTWH(  0, 0, manage.image.width * 0.02, manage.image.height * 0.02),
          fillPaint);
      canvas.restore();
    }

  }

  @override
  bool shouldRepaint(covariant WorldRender oldDelegate) =>
      oldDelegate.manage != manage;
}
