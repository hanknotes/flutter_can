import 'package:flutter/material.dart';
import 'package:flutter_can/main/model/MainPageTypeItemModel.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<MainPageTypeItemModel> list;

  @override
  void initState() {
    super.initState();
    list = [
      MainPageTypeItemModel("Canvas绘制特效", "CanvasWidgetsListPage"),
      MainPageTypeItemModel("Flutter特效组件", "SpecialWidgetsListPage"),
      MainPageTypeItemModel("Flutter widgets 大全", "FlutterWidgetsListPage"),
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
        child: ListView.separated(
            itemBuilder: (context, index) {
              MainPageTypeItemModel item = list[index];
              return ListTile(
                title: Text(item.typeName),
                leading: Icon(Icons.widgets),
                onTap: () {
                  Navigator.pushNamed(context, item.routeName);
                },
              );
            },
            separatorBuilder: (context, index) {
              return Container();
            },
            itemCount: list.length),
      ),
    );
  }
}
