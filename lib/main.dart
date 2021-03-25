import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_can/c01_paint/test_paint.dart';
import 'package:flutter_can/c02_canvas/test_canvas.dart';
import 'package:flutter_can/c02_canvas/test_canvas_image.dart';
import 'package:flutter_can/c02_canvas/test_canvas_path.dart';
import 'package:flutter_can/c03_wuziqi/c03.dart';
import 'package:flutter_can/c04/c04.dart';
import 'package:flutter_can/c13_tornado/TimeLine.dart';
import 'package:flutter_can/c14_3d/spaceman/c14_spaceman.dart';

import 'c01_paint/test_paint_blendmode.dart';
import 'c01_paint/test_paint_filter.dart';
import 'c01_paint/test_paint_shader.dart';
import 'c04/GradientCircularProgressRoute.dart';
import 'c05_matrix/c05_matrix.dart';
import 'c06_animation/test_Image_animation.dart';
import 'c06_animation/test_animateTweens.dart';
import 'c06_animation/test_animatebuilder.dart';
import 'c06_animation/test_animateswitcher.dart';
import 'c06_animation/test_animatiedlist.dart';
import 'c06_animation/test_animatiedwidget.dart';
import 'c06_animation/test_animation.dart';
import 'c06_animation/test_pageroutebuilder.dart';
import 'c08_bezier/test_bezier.dart';
import 'c09_bar/c09_bar.dart';
import 'c10_dashboard/c10_dashboard.dart';
import 'c11_particles/World.dart';
import 'c12_rain/C12Rain.dart';
import 'c14_3d/test3d/c14_3d.dart';


void main() {
  // 确定初始化
//  WidgetsFlutterBinding.ensureInitialized();
  //横屏
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  //全屏显示
//  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MainPage());
}
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: C14SpaceMan(),
    );
//    return Container(
//      color: Colors.white,
//      child: CustomPaint( // 使用CustomPaint
//        painter: Paint01(),
//      ),
//    );
  }
}