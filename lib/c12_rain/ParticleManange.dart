import 'package:flutter/material.dart';

import 'Particle.dart';
import 'dart:ui' as ui;
class ParticleManage with ChangeNotifier {
  // 粒子集合
  List<Particle> particles = [];

  Size size;
  ui.Image image;
  ParticleManage({this.size});

  void setImage(ui.Image image){
    this.image = image;
  }
  void addParticle(Particle particle) {
    particles.add(particle);
    notifyListeners();
  }

  void tick() {
    particles.forEach(doUpdate);
    notifyListeners();
  }

  void doUpdate(Particle p) {
    p.vy += p.ay; // y加速度变化
    p.vx += p.ax; // x加速度变化
    p.x += p.vx;
    p.y += p.vy;
    if (p.x > size.width) {
      p.x=size.width;
      p.vx=-p.vx;
    }
    if (p.x < 0) {
      p.x=0;
      p.vx=-p.vx;
    }
    if (p.y > size.height) {
      p.y=0;
    }
  }

}