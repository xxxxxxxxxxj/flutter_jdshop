import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/appconfig.dart';
import 'package:flutter_jdshop/res/color.dart';
import 'package:flutter_jdshop/res/strings.dart';
import 'package:flutter_jdshop/util/timer_util.dart';
import 'package:flutter_jdshop/util/utils.dart';
import 'package:flutter_jdshop/view/netimage_widget.dart';

class OpenAdPage extends StatefulWidget {
  Map arguments;

  OpenAdPage({this.arguments});

  @override
  State<StatefulWidget> createState() {
    return _OpenAdPageState();
  }
}

class _OpenAdPageState extends State<OpenAdPage> {
  int _count = 5;
  TimerUtil _timerUtil;

  @override
  void initState() {
    super.initState();
    _doCountDown();
  }

  void _doCountDown() {
    _timerUtil = new TimerUtil(mTotalTime: 5 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      setState(() {
        _count = _tick.toInt();
      });
      if (_tick == 0) {
        Navigator.pushReplacementNamed(context, PageName.route_main);
      }
    });
    _timerUtil.startCountDown();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, PageName.route_main);
              Utils.JumpTo(context, widget.arguments["_point"],
                  map: {"url": widget.arguments["_backup"]});
            },
            child: NetImage(widget.arguments["_imgUrl"]),
          ),
          new Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.all(20.0),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, PageName.route_main);
              },
              child: new Container(
                  padding: EdgeInsets.all(12.0),
                  child: new Text(
                    IntlUtil.getString(context, Ids.jump_count,
                        params: ['$_count']),
                    style: new TextStyle(fontSize: 14.0, color: Colors.white),
                  ),
                  decoration: new BoxDecoration(
                      color: Color(0x66000000),
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      border:
                          new Border.all(width: 0.33, color: Colours.divider))),
            ),
          )
        ],
      ),
    );
  }
}
