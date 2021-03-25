import 'package:flutter/material.dart';

import 'Particle.dart';

class ParticleManage with ChangeNotifier {
  // 粒子集合
  List<Particle> particles = [];

  Size size;

  ParticleManage({this.size});

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
    p.vx += p.ax;
    p.x += p.vx;
    p.y += p.vy;
    if (p.x > size.width) {
      p.x = size.width;
      p.vx = -p.vx;
    }
    if (p.x < 0) {
      p.x = 0;
      p.vx = -p.vx;
    }
    if (p.y > size.height) {
      p.y = size.height;
      p.vy = -p.vy;
    }
    if (p.y < 0) {
      p.y = 0;
      p.vy = -p.vy;
    }
  }

  // xy方向恒速运动
  void doUpdate1(Particle p) {
    p.x += p.vx;
    p.y += p.vy;
    if (p.x > size.width) {
      p.x = size.width;
      p.vx = -p.vx;
    }
    if (p.x < 0) {
      p.x = 0;
      p.vx = -p.vx;
    }
    if (p.y > size.height) {
      p.y = size.height;
      p.vy = -p.vy;
    }
    if (p.y < 0) {
      p.y = 0;
      p.vy = -p.vy;
    }
  }
}