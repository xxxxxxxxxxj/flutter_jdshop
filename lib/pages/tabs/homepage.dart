import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/bean/bannerbean.dart';
import 'package:flutter_jdshop/bean/prodcutbean.dart';
import 'package:flutter_jdshop/config/apiconfig.dart';
import 'package:flutter_jdshop/res/strings.dart';
import 'package:flutter_jdshop/view/netimage.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';
import 'package:flutter_jdshop/view/banner_widget.dart';
import 'package:flutter_jdshop/view/columntitle_widget.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with AutomaticKeepAliveClientMixin{
  List<BannerData> _bannerList = new List<BannerData>();
  List<ProductData> _likeList = new List<ProductData>();
  List<ProductData> _hotList = new List<ProductData>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    //网络请求获取banner数据
    _getBannerData();
    //网络请求获取猜你喜欢数据
    _getLikeData();
    //网络请求获取热门推荐数据
    _getHotData();
  }

  //异步方法
  _getBannerData() async {
    var dio = Dio();
    Response response = await dio.get(ApiConfig.HOME_TOP_BANNER);
    var bannerBean = BannerBean.fromJson(response.data);
    print(response.data);
    setState(() {
      _bannerList = bannerBean.result;
    });
  }

  //异步方法
  _getLikeData() async {
    var dio = Dio();
    Response response = await dio.get(ApiConfig.HOME_LIKE);
    var productBean = ProductBean.fromJson(response.data);
    print(response.data);
    setState(() {
      _likeList = productBean.result;
    });
  }

  //异步方法
  _getHotData() async {
    var dio = Dio();
    Response response = await dio.get(ApiConfig.HOME_HOT);
    var productBean = ProductBean.fromJson(response.data);
    print(response.data);
    setState(() {
      _hotList = productBean.result;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return ListView(
      children: <Widget>[
        //头部banner
        BannerWidget(_bannerList, 2.0),
        //间隔30像素
        SizedBox(
          height: ScreenAdapter.setHeight(30),
        ),
        //分类标题"猜你喜欢"
        ColumnTitleWidget(IntlUtil.getString(context, Ids.titleHomeLike)),
        //间隔30像素
        SizedBox(
          height: ScreenAdapter.setHeight(30),
        ),
        //左右滑动的列表
        _getLikeWidget(),
        //间隔30像素
        SizedBox(
          height: ScreenAdapter.setHeight(30),
        ),
        //分类标题"热门推荐"
        ColumnTitleWidget(IntlUtil.getString(context, Ids.titleHomeHot)),
        //间隔30像素
        SizedBox(
          height: ScreenAdapter.setHeight(30),
        ),
        //热门推荐网格列表
        _getHotWidget(),
      ],
    );
  }

  _getHotWidget() {
    return (_hotList != null && _hotList.length > 0)
        ? Container(
            margin: EdgeInsets.only(
                left: ScreenAdapter.setWidth(20),
                right: ScreenAdapter.setWidth(20),
                bottom: ScreenAdapter.setHeight(20)),
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
                      onTap: () {},
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: ScreenAdapter.setHeight(20)),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: NetImage(_hotList[index].pic),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    bottom: ScreenAdapter.setHeight(20)),
                                child: Text(
                                  _hotList[index].title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: ScreenAdapter.setSp(26)),
                                ),
                              ),
                              Stack(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "¥${_hotList[index].price}",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: ScreenAdapter.setSp(26)),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "¥${_hotList[index].oldPrice}",
                                      style: TextStyle(
                                          color: Colors.black54,
                                          //中间加横线
                                          decoration:
                                              TextDecoration.lineThrough,
                                          fontSize: ScreenAdapter.setSp(26)),
                                    ),
                                  )
                                ],
                              )
                            ],
                          )),
                    )),
          )
        : Text("加载中...");
  }

  _getLikeWidget() {
    return (_likeList != null && _likeList.length > 0)
        ? Container(
            margin: EdgeInsets.only(
                left: ScreenAdapter.setWidth(20),
                right: ScreenAdapter.setWidth(20)),
            height: ScreenAdapter.setHeight(200), //高度自适应
            width: double.maxFinite, //宽度充满
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _likeList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      //能够点击
                      onTap: () {},
                      child: Container(
                        width: ScreenAdapter.setWidth(140),
                        height: double.infinity,
                        margin: index == _likeList.length - 1
                            ? null
                            : EdgeInsets.only(
                                right: ScreenAdapter.setWidth(20)),
                        alignment: Alignment.center,
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: ScreenAdapter.setWidth(140),
                              height: ScreenAdapter.setHeight(140),
                              margin: EdgeInsets.only(bottom: 10),
                              child: NetImage(_likeList[index].pic),
                            ),
                            Text(
                              _likeList[index].title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(fontSize: ScreenAdapter.setSp(26)),
                            )
                          ],
                        ),
                      ));
                }),
          )
        : Text("加载中...");
  }
}
