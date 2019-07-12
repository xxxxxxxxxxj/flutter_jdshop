import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/config/apiconfig.dart';
import 'package:flutter_jdshop/config/appconfig.dart';
import 'package:flutter_jdshop/res/index.dart';
import 'package:flutter_jdshop/routers/router.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter_jdshop/util/log_util.dart';
import 'data/index.dart';
import 'package:package_info/package_info.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:fluintl/fluintl.dart';

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
    setLocalizedSimpleValues(localizedSimpleValues); //配置简单多语言资源
    //setLocalizedValues(localizedValues); //配置多语言资源
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
    //获取设备信息
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      _headers["device_model"] = androidInfo.model;
      _headers["device_device"] = androidInfo.device;
      _headers["device_brand"] = androidInfo.brand;
      _headers["device_product"] = androidInfo.product;
      _headers["device_androidId"] = androidInfo.androidId;
      _headers["device_id"] = androidInfo.id;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      _headers["device_model"] = iosInfo.model;
      _headers["device_name"] = iosInfo.name;
      _headers["device_systemName"] = iosInfo.systemName;
      _headers["device_systemVersion"] = iosInfo.systemVersion;
    }
    //获取app信息
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    _headers["appName"] = appName;
    _headers["packageName"] = packageName;
    _headers["version"] = version;
    _headers["buildNumber"] = buildNumber;
    LogUtil.e("_headers = " + _headers.toString());
    options.headers = _headers;
    DioUtil().setConfig(config);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      onGenerateRoute: onGenerateRoute,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        CustomLocalizations.delegate //设置本地化代理
      ],
      supportedLocales: CustomLocalizations.supportedLocales, //设置支持本地化语言集合
    );
  }
}
