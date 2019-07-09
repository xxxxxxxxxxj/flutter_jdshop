import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    //初始化flutter_screenutil
    ScreenUtil(width: 750, height: 1334)..init(context);
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(20)),
      padding: EdgeInsets.only(left: ScreenUtil.getInstance().setWidth(20)),
      decoration: BoxDecoration(
          border: Border(
              left: BorderSide(
        color: Colors.red,
        width: ScreenUtil.getInstance().setWidth(10),
      ))),
      child: Text(
        this._title,
        style: TextStyle(
            fontSize: ScreenUtil.getInstance().setSp(36),
            color: Colors.black54),
      ),
    );
  }
}
