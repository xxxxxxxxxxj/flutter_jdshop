import 'package:flutter/material.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';

class ColumnTitle extends StatefulWidget {
  String _title;

  ColumnTitle(this._title);

  @override
  State<StatefulWidget> createState() {
    return _ColumnTitleState(this._title);
  }
}

class _ColumnTitleState extends State<ColumnTitle> {
  String _title;

  _ColumnTitleState(this._title);

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: ScreenAdapter.setWidth(20)),
      padding: EdgeInsets.only(
          left: ScreenAdapter.setWidth(20),
          top: ScreenAdapter.setHeight(10),
          bottom: ScreenAdapter.setHeight(10)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
        color: Colors.red,
        width: ScreenAdapter.setWidth(10),
      ))),
      child: Text(
        this._title,
        style:
            TextStyle(fontSize: ScreenAdapter.setSp(36), color: Colors.black54),
      ),
    );
  }
}
