import 'package:flutter/material.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';

class SerchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SerchPageState();
  }
}

class _SerchPageState extends State<SerchPage> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Scaffold(
      appBar: AppBar(
        title: Container(
          alignment: Alignment.center,
          height: ScreenAdapter.setHeight(70),
          padding: EdgeInsets.only(left: ScreenAdapter.setWidth(20)),
          decoration: BoxDecoration(
              color: Color.fromRGBO(233, 233, 233, 0.8),
              borderRadius: BorderRadius.circular(30)),
          child: TextField(
            style: TextStyle(fontSize: ScreenAdapter.setSp(26)),
            autofocus: true, //自动获取焦点，弹起键盘
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide.none)),
          ),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {},
            child: Container(
              margin: EdgeInsets.only(
                  left: ScreenAdapter.setWidth(40),
                  right: ScreenAdapter.setWidth(40)),
              alignment: Alignment.center,
              child: Text(
                "搜索",
                style: TextStyle(fontSize: ScreenAdapter.setSp(26)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
