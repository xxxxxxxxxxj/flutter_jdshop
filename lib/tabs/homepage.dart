import 'package:flutter/material.dart';
import 'package:flutter_jdshop/bean/banner_bean.dart';
import 'package:flutter_jdshop/view/banner.dart';
import 'package:flutter_jdshop/view/columntitle.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<BannerBean> _imgList = new List<BannerBean>();

  @override
  void initState() {
    super.initState();
    _imgList.add(
        BannerBean("https://www.itying.com/images/flutter/slide01.jpg", 0, ""));
    _imgList.add(
        BannerBean("https://www.itying.com/images/flutter/slide02.jpg", 0, ""));
    _imgList.add(
        BannerBean("https://www.itying.com/images/flutter/slide03.jpg", 0, ""));
  }

  @override
  Widget build(BuildContext context) {
    //初始化flutter_screenutil
    ScreenUtil(width: 750, height: 1334)..init(context);
    return ListView(
      children: <Widget>[
        BannerDefault(_imgList, 2.0),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(30),
        ),
        ColumnTitle("猜你喜欢"),
        SizedBox(
          height: ScreenUtil.getInstance().setHeight(30),
        ),
        ColumnTitle("热门推荐"),
      ],
    );
  }
}
