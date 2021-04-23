import 'package:flutter_can/main/flutter_widgets/model/FlutterWidgetsChildTypeItemModel.dart';

class FlutterWidgetsTypeItemModel{
  String typeName;
  List<FlutterWidgetsChildTypeItemModel> children;

  FlutterWidgetsTypeItemModel(this.typeName, this.children);
}