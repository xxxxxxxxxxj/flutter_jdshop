import 'package:flutter/material.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';
import 'package:flutter_jdshop/util/utils.dart';

class ColumnTitleWidget extends StatefulWidget {
  String _title;

  ColumnTitleWidget(this._title);

  @override
  State<StatefulWidget> createState() {
    return _ColumnTitleWidgetState(this._title);
  }
}

class _ColumnTitleWidgetState extends State<ColumnTitleWidget> {
  String _title;

  _ColumnTitleWidgetState(this._title);

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
        Utils.getStr(this._title),
        style:
            TextStyle(fontSize: ScreenAdapter.setSp(36), color: Colors.black54),
      ),
    );
  }
}
