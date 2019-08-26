import 'package:flutter/material.dart';

class OrderPayPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OrderPayPageState();
  }
}

class _OrderPayPageState extends State<OrderPayPage> {
  String _aliValue;
  String _wxValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("收银台"),
      ),
      body: ListView(
        children: <Widget>[
          RadioListTile<String>(
            value: '微信',
            title: Text('微信'),
            groupValue: _wxValue,
            onChanged: (value) {
              setState(() {
                _wxValue = value;
              });
            },
          ),
          RadioListTile<String>(
            value: '支付宝',
            title: Text('支付宝'),
            groupValue: _aliValue,
            onChanged: (value) {
              setState(() {
                _aliValue = value;
              });
            },
          ),
        ],
      ),
    );
  }
}
