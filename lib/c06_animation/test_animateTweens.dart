import 'package:flutter/material.dart';

class TestAnimateTweens extends StatefulWidget {
  @override
  _TestImageAnimationState createState() => _TestImageAnimationState();
}

class _TestImageAnimationState extends State<TestAnimateTweens>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = new AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
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
    return ImageAnimatiedWidget2(
      animation: controller,
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
  final _sizeTween = new Tween(begin: 0.0,end: 300.0);
  final _opacityTween = new Tween(begin: 0.0,end: 1.0);

  @override
  Widget build(BuildContext context) {
    Animation animation = listenable;
    return Center(
      child: Opacity(
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          child: Image.asset(
            "images/a2.png",
            width: _sizeTween.evaluate(animation),
            height: _sizeTween.evaluate(animation),
          ),
          // width: animation.value,
          // height: animation.value,
        ),
      ),
    );
  }

  ImageAnimatiedWidget({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);
}


class ImageAnimatiedWidget2 extends AnimatedWidget {
  final _sizeTween = new Tween(begin: 0.0,end: 300.0);
  final _opacityTween = new Tween(begin: 0.0,end: 1.0);

  @override
  Widget build(BuildContext context) {
    Animation animation = listenable;
    return Center(
      child: Opacity(
        opacity: _opacityTween.animate(new CurvedAnimation(parent: animation, curve: new Interval(0.5, 1,curve: Curves.ease))).value,
        child: Container(
          child: Image.asset(
            "images/a2.png",
            width: _sizeTween.animate(new CurvedAnimation(parent: animation, curve: new Interval(0, 0.6,curve: Curves.easeIn))).value,
            height: _sizeTween.animate(new CurvedAnimation(parent: animation, curve: new Interval(0,0.6,curve: Curves.easeIn))).value,
          ),
          // width: animation.value,
          // height: animation.value,
        ),
      ),
    );
  }

  ImageAnimatiedWidget2({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);
}