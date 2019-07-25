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
      ],
    );
  }
}
