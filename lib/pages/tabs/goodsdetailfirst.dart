import 'package:flutter/material.dart';
import 'package:flutter_jdshop/bean/bannerbean.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';
import 'package:flutter_jdshop/view/banner_widget.dart';

class GoodsDetailFirst extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GoodsDetailFirstState();
  }
}

class _GoodsDetailFirstState extends State<GoodsDetailFirst> {
  List<BannerData> _bannerList = new List<BannerData>();
  String _title = "";
  String _subTitle = "";
  double _price = 0;
  double _listPrice = 0;
  String _freight = "";
  String _selectSpecifications = "";

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return ListView(
      children: <Widget>[
        //头部banner
        BannerWidget(_bannerList, 16 / 9),
        //间隔30像素
        SizedBox(
          height: ScreenAdapter.setHeight(30),
        ),
        Text(
          _title,
          style:
              TextStyle(fontSize: ScreenAdapter.setSp(36), color: Colors.black),
        ),
        SizedBox(
          height: ScreenAdapter.setHeight(30),
        ),
        Text(
          _subTitle,
          style: TextStyle(
              fontSize: ScreenAdapter.setSp(28), color: Colors.black26),
        ),
        SizedBox(
          height: ScreenAdapter.setHeight(30),
        ),
        Container(
          margin: EdgeInsets.only(
              left: ScreenAdapter.setWidth(15),
              right: ScreenAdapter.setWidth(15),
              bottom: ScreenAdapter.setHeight(60)),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 1,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "特价：",
                        style: TextStyle(
                            fontSize: ScreenAdapter.setSp(24),
                            color: Colors.black54),
                      ),
                      Text(
                        "¥${_price}",
                        style: TextStyle(
                            fontSize: ScreenAdapter.setSp(36),
                            color: Colors.red),
                      ),
                    ],
                  )),
              Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "原价：",
                        style: TextStyle(
                            fontSize: ScreenAdapter.setSp(24),
                            color: Colors.black54),
                      ),
                      Text(
                        "¥${_listPrice}",
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            fontSize: ScreenAdapter.setSp(36),
                            color: Colors.black26),
                      ),
                    ],
                  )),
            ],
          ),
        ),
        Container(
            height: ScreenAdapter.setHeight(100),
            margin: EdgeInsets.only(
                left: ScreenAdapter.setWidth(15),
                right: ScreenAdapter.setWidth(15),
                bottom: ScreenAdapter.setHeight(30)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "已选：",
                  style: TextStyle(
                      fontSize: ScreenAdapter.setSp(24), color: Colors.black),
                ),
                Text(
                  _selectSpecifications,
                  style: TextStyle(
                      fontSize: ScreenAdapter.setSp(24), color: Colors.black54),
                ),
              ],
            )),
        Divider(
          height: ScreenAdapter.setHeight(2),
          color: Color.fromRGBO(233, 233, 233, 0.8),
        ),
        Container(
            height: ScreenAdapter.setHeight(100),
            margin: EdgeInsets.only(
                left: ScreenAdapter.setWidth(15),
                right: ScreenAdapter.setWidth(15),
                bottom: ScreenAdapter.setHeight(30)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "运费：",
                  style: TextStyle(
                      fontSize: ScreenAdapter.setSp(24), color: Colors.black),
                ),
                Text(
                  _freight,
                  style: TextStyle(
                      fontSize: ScreenAdapter.setSp(24), color: Colors.black54),
                ),
              ],
            )),
        Divider(
          height: ScreenAdapter.setHeight(2),
          color: Color.fromRGBO(233, 233, 233, 0.8),
        ),
      ],
    );
  }
}
