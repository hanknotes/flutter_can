import 'package:flutter/material.dart';

class TestImageAnimation extends StatefulWidget {
  @override
  _TestImageAnimationState createState() => _TestImageAnimationState();
}

class _TestImageAnimationState extends State<TestImageAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Image.asset("images/a2.png"),
        width: animation.value,
        height: animation.value,
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
}
