import 'package:flutter/material.dart';

class TestAnimateBuilder extends StatefulWidget {
  @override
  _TestImageAnimationState createState() => _TestImageAnimationState();
}

class _TestImageAnimationState extends State<TestAnimateBuilder>
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
    return ImageAnimateBuilder(animation, MyImage());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
}

class ImageAnimateBuilder extends StatelessWidget {
  final Animation animation;
  final Widget child;

  ImageAnimateBuilder(this.animation, this.child);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        child: child,
        builder: (BuildContext context,Widget child){
          return Container(
            width: animation.value,
            height: animation.value,
            child: child,
          );
        },
      ),
    );
  }
}

class MyImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Image.asset(
          "images/a2.png",
        ),
        // width: animation.value,
        // height: animation.value,
      ),
    );
  }
}
