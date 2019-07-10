import 'package:flutter/material.dart';
import 'package:flutter_jdshop/bean/banner_bean.dart';
import 'package:flutter_jdshop/bean/hotbean.dart';
import 'package:flutter_jdshop/bean/likebean.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';
import 'package:flutter_jdshop/view/banner.dart';
import 'package:flutter_jdshop/view/columntitle.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  List<BannerBean> _imgList = new List<BannerBean>();
  List<LikeBean> _likeList = new List<LikeBean>();
  List<HotBean> _hotList = new List<HotBean>();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 10; i++) {
      _likeList.add(LikeBean(
          "https://www.itying.com/images/flutter/hot${i + 1}.jpg",
          0,
          "",
          "第${i + 1}条"));
      _imgList.add(BannerBean(
          "https://www.itying.com/images/flutter/slide0${((i + 1) % 3) + 1}.jpg",
          0,
          ""));
      _hotList.add(HotBean("https://www.itying.com/images/flutter/list1.jpg", 0,
          "", "2019夏季新款气质高贵洋气阔太太有女人味中长款宽松大码", 188.0, 198.0));
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return ListView(
      children: <Widget>[
        //头部banner
        BannerDefault(_imgList, 2.0),
        //间隔30像素
        SizedBox(
          height: ScreenAdapter.setHeight(30),
        ),
        //分类标题"猜你喜欢"
        ColumnTitle("猜你喜欢"),
        //间隔30像素
        SizedBox(
          height: ScreenAdapter.setHeight(30),
        ),
        //左右滑动的列表
        _getLikeData(),
        //间隔30像素
        SizedBox(
          height: ScreenAdapter.setHeight(30),
        ),
        //分类标题"热门推荐"
        ColumnTitle("热门推荐"),
        //间隔30像素
        SizedBox(
          height: ScreenAdapter.setHeight(30),
        ),
        //热门推荐网格列表
        _getHotRecommendData(),
      ],
    );
  }

  _getHotRecommendData() {
    return Container(
      margin: EdgeInsets.only(
          left: ScreenAdapter.setWidth(20), right: ScreenAdapter.setWidth(20)),
      child: GridView.builder(
          //ListView和GridView嵌套问题，以下两个属性
          physics: new NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _hotList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: ScreenAdapter.setWidth(20),
              crossAxisSpacing: ScreenAdapter.setHeight(20),
              childAspectRatio: 1 / 1.4),
          itemBuilder: (context, index) => InkWell(
                onTap: () {
                  if (_hotList[index].point > 0) {
                    Fluttertoast.showToast(msg: "跳转");
                  } else {
                    Fluttertoast.showToast(msg: "不跳转");
                  }
                },
                child: Container(
                    padding: EdgeInsets.only(
                        left: ScreenAdapter.setWidth(20),
                        right: ScreenAdapter.setWidth(20),
                        top: ScreenAdapter.setHeight(20),
                        bottom: ScreenAdapter.setHeight(20)),
                    decoration: BoxDecoration(
                        border: Border.all(
                            //设置边框
                            color: Color.fromRGBO(233, 233, 233, 0.9),
                            width: ScreenAdapter.setWidth(1))),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: ScreenAdapter.setHeight(20)),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Image.network(_hotList[index].imgUrl),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: ScreenAdapter.setHeight(20)),
                          child: Text(
                            _hotList[index].title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        Stack(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "¥${_hotList[index].price}",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                "¥${_hotList[index].listPrice}",
                                style: TextStyle(
                                    color: Colors.black54,
                                    //中间加横线
                                    decoration: TextDecoration.lineThrough),
                              ),
                            )
                          ],
                        )
                      ],
                    )),
              )),
    );
  }

  Container _getLikeData() {
    return Container(
      margin: EdgeInsets.only(
          left: ScreenAdapter.setWidth(20), right: ScreenAdapter.setWidth(20)),
      height: ScreenAdapter.setHeight(201), //高度自适应
      width: double.maxFinite, //宽度充满
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _likeList.length,
          itemBuilder: (context, index) {
            return InkWell(
                //能够点击
                onTap: () {
                  if (_likeList[index].point > 0) {
                    Fluttertoast.showToast(msg: "跳转");
                  } else {
                    Fluttertoast.showToast(msg: "不跳转");
                  }
                },
                child: Container(
                  margin: index == _likeList.length - 1
                      ? null
                      : EdgeInsets.only(right: ScreenAdapter.setWidth(20)),
                  alignment: Alignment.center,
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: ScreenAdapter.setWidth(140),
                        height: ScreenAdapter.setHeight(140),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Image.network(
                          _likeList[index].imgUrl,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Text(
                        _likeList[index].title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ));
          }),
    );
  }
}
