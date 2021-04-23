import 'package:flutter/material.dart';
import 'package:flutter_can/main/model/MainPageTypeItemModel.dart';

class CanvasWidgetsListPage extends StatefulWidget {
  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<CanvasWidgetsListPage> {
  List<MainPageTypeItemModel> list;

  @override
  void initState() {
    super.initState();
    list = [
      MainPageTypeItemModel("c01_tornado 龙卷风", "TornadoMainPage"),
      MainPageTypeItemModel("c02_spaceman 太空人", "SpaceManMainPage"),
      MainPageTypeItemModel("c03_rain 雨", "RainMainPage"),
      MainPageTypeItemModel("c04_cardashboard 汽车仪表盘", "CarDashBoardMainPage"),
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
