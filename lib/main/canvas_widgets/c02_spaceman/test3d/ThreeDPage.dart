import 'package:flutter/material.dart';

import 'ThreeDPainter.dart';

class ThreeDPage extends StatefulWidget {
  @override
  _Test3dState createState() => _Test3dState();
}

class _Test3dState extends State<ThreeDPage> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(vsync: this,duration: const Duration(seconds: 18));
    _controller.repeat();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: ThreeDPainter(_controller),
      ),
    );
  }
}
