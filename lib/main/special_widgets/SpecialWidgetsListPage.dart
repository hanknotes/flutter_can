import 'package:flutter/material.dart';
import 'model/SpecialWidgetsChildTypeItemModel.dart';
import 'model/SpecialWidgetsTypeItemModel.dart';

class SpecialWidgetsListPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<SpecialWidgetsListPage> {
  List<SpecialWidgetsTypeItemModel> list;

  @override
  void initState() {
    super.initState();
    list = [
      SpecialWidgetsTypeItemModel(
          '基础组件', [SpecialWidgetsChildTypeItemModel("Text", "")]),
      SpecialWidgetsTypeItemModel('布局类组件', []),
      SpecialWidgetsTypeItemModel('容器类组件', []),
      SpecialWidgetsTypeItemModel('可滚动类组件', []),
      SpecialWidgetsTypeItemModel('功能性组件', []),
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
                    SpecialWidgetsChildTypeItemModel childItem =
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
