import 'package:common_utils/common_utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/apiconfig.dart';
import 'package:flutter_jdshop/config/appconfig.dart';
import 'package:flutter_jdshop/routers/router.dart';

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
    BaseOptions options = DioUtil.getDefOptions();
    options.baseUrl = ApiConfig.BASE_URL;
    HttpConfig config = new HttpConfig(options: options);
    DioUtil().setConfig(config);
    LogUtil.init(isDebug: AppConfig.isLogDeBug, tag: AppConfig.logTag);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      onGenerateRoute: onGenerateRoute,
    );
  }
}
