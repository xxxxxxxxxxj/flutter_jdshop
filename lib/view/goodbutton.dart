import 'package:flutter/material.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';

class GoodButton extends StatefulWidget {
  final Color color;
  final String text;
  final Object cb;

  GoodButton({this.color = Colors.black, this.text = "按钮", this.cb = null});

  @override
  State<StatefulWidget> createState() {
    return _GoodButtonState();
  }
}

class _GoodButtonState extends State<GoodButton> {
  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return InkWell(
      onTap: this.widget.cb,
      child: Container(
        height: ScreenAdapter.setHeight(68),
        width: double.infinity,
        decoration: BoxDecoration(
            color: widget.color, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            "${widget.text}",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
