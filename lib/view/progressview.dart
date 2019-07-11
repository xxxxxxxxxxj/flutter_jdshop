import 'package:flutter/material.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';

class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new SizedBox(
        width: ScreenAdapter.setWidth(24.0),
        height: ScreenAdapter.setHeight(24.0),
        child: new CircularProgressIndicator(
          strokeWidth: ScreenAdapter.setWidth(2.0),
        ),
      ),
    );
  }
}
