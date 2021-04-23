import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'Particle.dart';
import 'ParticleManange.dart';
import 'WorldRender.dart';
import 'dart:ui' as ui;

class RainMainPage extends StatefulWidget {
  @override
  _RainMainPageState createState() => _RainMainPageState();
}

class _RainMainPageState extends State<RainMainPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  ParticleManage pm = ParticleManage();
  ui.Image _src;

  @override
  void initState() {
    super.initState();
    _loadImage();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )
      ..addListener(pm.tick)
      ..repeat();
  }

  void _loadImage() async {
    _src = await loadImageFromAssets('images/sword.png');
    setState(() {});
    initParticleManage();
  }

  Future<ui.Image> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return decodeImageFromList(bytes);
  }

  initParticleManage() {
    pm.size = Size(600, 400);
    pm.image = _src;
    for (var i = 0; i < 160; i++) {
      Random random = Random();
      pm.addParticle(Particle(
        x: pm.size.width / 60 * i,
        y: 0,
        vx: 1 * random.nextDouble() * pow(-1, random.nextInt(20)),
        vy: 20 * random.nextDouble() + 1,
      ));
    }
  }

  Color randomColor({
    int limitR = 0,
    int limitG = 0,
    int limitB = 0,
  }) {
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

  theWorld() {
    if (_controller.isAnimating) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("雨"),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: theWorld,
        child: CustomPaint(
          size: pm.size,
          painter: WorldRender(manage: pm),
        ),
      ),
    );
  }
}
