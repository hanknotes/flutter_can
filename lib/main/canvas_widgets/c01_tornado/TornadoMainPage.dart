import 'dart:math';

import 'package:flutter/material.dart';

import 'AxisManager.dart';
import 'Particle.dart';
import 'ParticleManager.dart';
import 'TornadoRender.dart';

class TornadoMainPage extends StatefulWidget {
  @override
  _TornadoMainPageState createState() => _TornadoMainPageState();
}

class _TornadoMainPageState extends State<TornadoMainPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ParticleManager pm;
  AxisManager am;

  @override
  void initState() {
    super.initState();
    am = new AxisManager();
    pm = new ParticleManager(am);
    initParticleManager();
    _controller = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    _controller.addListener(() {
      am.tick();
      pm.tick();
    });
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("龙卷风"),
        centerTitle: true,
      ),
      body: Container(
        child: CustomPaint(
          size: MediaQuery.of(context).size,
          painter: TornadoRender(pm),
        ),
      ),
    );
  }

  void initParticleManager() {
    int num = 500;
    for (int i = 0; i < num; i++) {
      Random random = Random();
      pm.add(Particle(
          initRotate: pi * 2 * i / num,
          cur: 100 * i / num,
          curStep: random.nextDouble(),
          vy: -1 + random.nextDouble()));
    }
  }
}
