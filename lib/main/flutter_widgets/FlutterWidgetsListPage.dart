import 'package:flutter/material.dart';
import 'package:flutter_can/main/flutter_widgets/model/FlutterWidgetsChildTypeItemModel.dart';
import 'package:flutter_can/main/flutter_widgets/model/FlutterWidgetsTypeItemModel.dart';

class FlutterWidgetsListPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<FlutterWidgetsListPage> {
  List<FlutterWidgetsTypeItemModel> list;

  @override
  void initState() {
    super.initState();
    list = [
      FlutterWidgetsTypeItemModel(
          '基础组件', [FlutterWidgetsChildTypeItemModel("Text", "")]),
      FlutterWidgetsTypeItemModel('布局类组件', []),
      FlutterWidgetsTypeItemModel('容器类组件', []),
      FlutterWidgetsTypeItemModel('可滚动类组件', []),
      FlutterWidgetsTypeItemModel('功能性组件', []),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("light"),
        centerTitle: true,
      ),
      body: Container(
        child: ExpansionPanelList(
          children: list.map((typeItem) {
            return ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return new ListTile(
                    title: new Text(typeItem.typeName),
                  );
                },
                body: ListView.builder(
                  itemBuilder: (context, index) {
                    FlutterWidgetsChildTypeItemModel childItem =
                        typeItem.children[index];
                    return new ListTile(
                      title: new Text(childItem.typeName),
                    );
                  },
                  itemCount: typeItem.children.length,
                ));
          }).toList(),
        ),
      ),
    );
  }
}
