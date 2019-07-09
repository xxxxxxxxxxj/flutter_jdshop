import 'package:flutter/material.dart';
import 'package:flutter_jdshop/routers/router.dart';

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
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      onGenerateRoute: onGenerateRoute,
    );
  }
}
