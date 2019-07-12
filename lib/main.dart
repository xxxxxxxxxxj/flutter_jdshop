import 'dart:io';

import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_jdshop/config/apiconfig.dart';
import 'package:flutter_jdshop/config/appconfig.dart';
import 'package:flutter_jdshop/routers/router.dart';
import 'package:device_info/device_info.dart';
import 'data/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    //初始化日志模块
    LogUtil.init(isDebug: AppConfig.isLogDeBug, tag: AppConfig.logTag);
    //初始化网络请求模块
    BaseOptions options = DioUtil.getDefOptions();
    options.baseUrl = ApiConfig.BASE_URL;
    HttpConfig config = new HttpConfig(options: options);
    Map<String, dynamic> _headers = new Map();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      _headers["device_info"] = androidInfo;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      _headers["device_info"] = iosInfo;
    }
    LogUtil.e("_headers = " + _headers.toString());
    options.headers = _headers;
    DioUtil().setConfig(config);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      onGenerateRoute: onGenerateRoute,
    );
  }
}
