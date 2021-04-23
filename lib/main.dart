import 'package:flutter/material.dart';
import 'main/MainPage.dart';
import 'main/canvas_widgets/index.dart';
import 'main/flutter_widgets//index.dart';
import 'main/special_widgets/index.dart';


void main() {
  // 确定初始化
//  WidgetsFlutterBinding.ensureInitialized();
  //横屏
//  SystemChrome.setPreferredOrientations(
//      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  //全屏显示
//  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    routes: {

      // canvas相关
      "CanvasWidgetsListPage":(context) => CanvasWidgetsListPage(),
      "TornadoMainPage":(context) => TornadoMainPage(),
      "SpaceManMainPage":(context) => SpaceManMainPage(),
      "RainMainPage":(context) => RainMainPage(),
      "CarDashBoardMainPage":(context) => CarDashBoardMainPage(),

      // 特效相关
      "SpecialWidgetsListPage":(context) => SpecialWidgetsListPage(),

      // flutter支持的widget
      "FlutterWidgetsListPage": (context) => FlutterWidgetsListPage(),
    },
    home: MainPage(),
  ));
}
