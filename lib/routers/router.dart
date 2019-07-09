import 'package:flutter/material.dart';
import 'package:flutter_jdshop/tabs/tabs.dart';

//配置路由
final routers = {
  "/": (context) => Tabs(),
}; //固定写法

var onGenerateRoute = (RouteSettings settings) {
// 统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routers[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};
