import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Center(
      child: new SizedBox(
        child: new CupertinoActivityIndicator(),
      ),
    );
  }
}
