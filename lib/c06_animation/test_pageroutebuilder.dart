import 'package:flutter/material.dart';
import 'package:flutter_can/c06_animation/test_animateTweens.dart';

class TestPageRouteBuilder extends StatefulWidget {
  @override
  _TestImageAnimationState createState() => _TestImageAnimationState();
}

class _TestImageAnimationState extends State<TestPageRouteBuilder>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(onPressed: (){
        Navigator.push(context, PageRouteBuilder(
          transitionDuration: const Duration(seconds: 3),
            pageBuilder: (BuildContext context,Animation animation,Animation secondaryAnimation){
              return new FadeTransition(opacity: animation,child: TestAnimateTweens());
            }
        ));
      }, child: Text("aaa")),
    );
  }
}

