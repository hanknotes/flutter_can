import 'package:flutter/material.dart';

import 'SpaceMan.dart';

class SpaceManMainPage extends StatefulWidget {
  @override
  _SpaceManMainPageState createState() => _SpaceManMainPageState();
}

class _SpaceManMainPageState extends State<SpaceManMainPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
        vsync: this, duration: const Duration(seconds: 1));
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("太空人"),
        centerTitle: true,
      ),
      body: Container(
        child: CustomPaint(
          size: MediaQuery.of(context).size,
          painter: SpaceMan(_controller),
        ),
      ),
    );
  }
}
