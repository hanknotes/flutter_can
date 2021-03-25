import 'package:flutter/material.dart';

class TestAnimatiedWidget extends StatefulWidget {
  @override
  _TestImageAnimationState createState() => _TestImageAnimationState();
}

class _TestImageAnimationState extends State<TestAnimatiedWidget>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = new Tween(begin: 0.0, end: 300.0).animate(controller);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return ImageAnimatiedWidget(
      animation: animation,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
}

class ImageAnimatiedWidget extends AnimatedWidget {
  @override
  Widget build(BuildContext context) {
    Animation animation = listenable;
    return Center(
      child: Container(
        child: Image.asset(
          "images/a2.png",
          width: animation.value,
          height: animation.value,
        ),
        // width: animation.value,
        // height: animation.value,
      ),
    );
  }

  ImageAnimatiedWidget({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);
}
