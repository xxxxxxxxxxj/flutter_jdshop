import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/appconfig.dart';
import 'package:flutter_jdshop/util/log_util.dart';
import 'package:flutter_jdshop/util/sp_util.dart';
import 'package:flutter_jdshop/util/timer_util.dart';
import 'package:flutter_jdshop/util/utils.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  TimerUtil _timerUtil;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    bool isGuide = SpUtil.getBool(SPKey.key_isguide);
    LogUtil.e("isGuide = ${isGuide}");
    if (isGuide) {
      //进入主界面
      //请求开屏广告

    } else {
      //进入引导页
      _doCountDown();
    }
  }

  void _doCountDown() {
    _timerUtil = new TimerUtil(mTotalTime: 2 * 1000);
    _timerUtil.setOnTimerTickCallback((int tick) {
      double _tick = tick / 1000;
      if (_tick == 0) {
        Navigator.popAndPushNamed(context, PageName.route_guide);
      }
    });
    _timerUtil.startCountDown();
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Utils.getImgPath('splash_bg'),
      width: double.infinity,
      fit: BoxFit.fill,
      height: double.infinity,
    );
  }

  @override
  void dispose() {
    _timerUtil.cancel();
    super.dispose();
  }
}
