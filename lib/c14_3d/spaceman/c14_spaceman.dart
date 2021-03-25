import 'package:flutter/material.dart';
import 'package:flutter_can/c14_3d/spaceman/SpaceMan.dart';


class C14SpaceMan extends StatefulWidget {
  @override
  _Test3dState createState() => _Test3dState();
}

class _Test3dState extends State<C14SpaceMan> with SingleTickerProviderStateMixin{

  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(vsync: this,duration: const Duration(seconds: 1));
    _controller.repeat();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: SpaceMan(_controller),
      ),
    );
  }
}
