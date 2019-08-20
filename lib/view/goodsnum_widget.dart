import 'package:flutter/material.dart';
import 'package:flutter_jdshop/event/event.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GoodsNumWidget extends StatefulWidget {
  int flag;
  int num;
  int index;

  GoodsNumWidget(this.flag, this.num, this.index);

  @override
  State<StatefulWidget> createState() {
    return _GoodsNumWidgetState();
  }
}

class _GoodsNumWidgetState extends State<GoodsNumWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.setWidth(164),
      height: ScreenAdapter.setHeight(45),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
              color: Colors.black26, width: ScreenAdapter.setWidth(1))),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              if (widget.num <= 1) {
                Fluttertoast.showToast(msg: "数量不能小于1");
              } else {
                setState(() {
                  widget.num--;
                  eventBus.fire(
                      CartNumEvent(widget.flag, widget.num, widget.index));
                });
              }
            },
            child: Container(
              width: ScreenAdapter.setWidth(45),
              height: ScreenAdapter.setHeight(45),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      right: BorderSide(
                          color: Colors.black26,
                          width: ScreenAdapter.setWidth(1)))),
              child: Text(
                "-",
                style: TextStyle(
                    fontSize: ScreenAdapter.setSp(20), color: Colors.black),
              ),
            ),
          ),
          Container(
            width: ScreenAdapter.setWidth(70),
            height: ScreenAdapter.setHeight(45),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    right: BorderSide(
                        color: Colors.black26,
                        width: ScreenAdapter.setWidth(1)))),
            child: Text(
              "${widget.num}",
              style: TextStyle(
                  fontSize: ScreenAdapter.setSp(24), color: Colors.black),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                widget.num++;
                eventBus
                    .fire(CartNumEvent(widget.flag, widget.num, widget.index));
              });
            },
            child: Container(
              width: ScreenAdapter.setWidth(45),
              height: ScreenAdapter.setHeight(45),
              alignment: Alignment.center,
              child: Text(
                "+",
                style: TextStyle(
                    fontSize: ScreenAdapter.setSp(20), color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
