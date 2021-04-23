import 'package:flutter/material.dart';
import 'dart:math';
import 'Particle.dart';
import 'ParticleManange.dart';
import 'WorldRender.dart';

class World extends StatefulWidget {
  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ParticleManage pm = ParticleManage();

  @override
  void initState() {
    super.initState();
    initParticleManage(); // Todo 初始化粒子管理器

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    ) ..addListener(pm.tick)..repeat();
  }

  initParticleManage(){
    pm.size = Size(300, 200);

    for(var i=0;i<20;i++){
      Random random = Random();
      pm.addParticle(Particle(
          x: 0,
          y: 0,
          vx: 2+random.nextDouble(),
          vy:random.nextDouble(),
          ay:0.05,
          color: randomColor(),
          size: 8));
    }
  }

  Color randomColor({int limitR = 0, int limitG = 0, int limitB = 0,}){
    Random random = Random();
    var r = limitR + random.nextInt(256 - limitR); //红值
    var g = limitG + random.nextInt(256 - limitG); //绿值
    var b = limitB + random.nextInt(256 - limitB); //蓝值
    return Color.fromARGB(255, r, g, b); //生成argb模式的颜色
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  theWorld(){
    if (_controller.isAnimating) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: theWorld,
      child: CustomPaint(
        size: pm.size,
        painter: WorldRender(manage: pm),
      ),
    );
  }
}