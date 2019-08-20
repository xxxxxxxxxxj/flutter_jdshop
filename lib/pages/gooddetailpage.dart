import 'package:dio/dio.dart';
import 'package:fluintl/fluintl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jdshop/bean/goodsdetailbean.dart';
import 'package:flutter_jdshop/config/apiconfig.dart';
import 'package:flutter_jdshop/config/appconfig.dart';
import 'package:flutter_jdshop/event/buyorcartevent.dart';
import 'package:flutter_jdshop/pages/tabs/goodsdetailfirst.dart';
import 'package:flutter_jdshop/pages/tabs/goodsdetailsecond.dart';
import 'package:flutter_jdshop/pages/tabs/goodsdetailthird.dart';
import 'package:flutter_jdshop/res/strings.dart';
import 'package:flutter_jdshop/util/object_util.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';
import 'package:flutter_jdshop/view/goodbutton.dart';
import 'package:flutter_jdshop/view/loading_widget.dart';

class GoodDetailPage extends StatefulWidget {
  Map arguments;

  GoodDetailPage({this.arguments});

  @override
  State<StatefulWidget> createState() {
    return _GoodDetailPageState();
  }
}

class _GoodDetailPageState extends State<GoodDetailPage> {
  GoodsDetailData _goodsDetailData;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  _getData() async {
    var dio = Dio();
    Response response =
        await dio.get(ApiConfig.GOODS_DETAIL + "?id=" + widget.arguments["id"]);
    var goodsDetailBean = GoodsDetailBean.fromJson(response.data);
    print(response.data);
    setState(() {
      _goodsDetailData = goodsDetailBean.result;
      List<Attr> attr = _goodsDetailData.attr;
      for (int i = 0; i < attr.length; i++) {
        List<String> list = attr[i].list;
        List<AttrData> attrList = new List<AttrData>();
        for (int j = 0; j < list.length; j++) {
          attrList.add(new AttrData(list[j], false));
        }
        attr[i].attrList = attrList;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
              indicatorColor: Colors.red,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: <Widget>[
                Tab(
                  text: IntlUtil.getString(context, Ids.goods),
                ),
                Tab(
                  text: IntlUtil.getString(context, Ids.detail),
                ),
                Tab(
                  text: IntlUtil.getString(context, Ids.evaluation),
                )
              ]),
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.more_horiz),
                onPressed: () {
                  showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(
                          ScreenAdapter.setWidth(600),
                          ScreenAdapter.setHeight(200),
                          ScreenAdapter.setWidth(20),
                          0),
                      items: [
                        PopupMenuItem(
                            child: Row(
                          children: <Widget>[
                            InkWell(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.home),
                                  Text(IntlUtil.getString(
                                      context, Ids.titleHome)),
                                ],
                              ),
                            ),
                          ],
                        )),
                        PopupMenuItem(
                            child: Row(
                          children: <Widget>[
                            InkWell(
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.search),
                                  Text(IntlUtil.getString(
                                      context, Ids.titleHome)),
                                ],
                              ),
                            ),
                          ],
                        )),
                      ]);
                }),
          ],
        ),
        body: ObjectUtil.isNotEmpty(_goodsDetailData)
            ? Stack(
                children: <Widget>[
                  TabBarView(children: [
                    GoodsDetailFirst(_goodsDetailData),
                    GoodsDetailSecond(widget.arguments["id"]),
                    GoodsDetailThird(),
                  ]),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        width: ScreenAdapter.setWidth(750),
                        height: ScreenAdapter.setHeight(100),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                                top: BorderSide(
                                    color: Colors.black38,
                                    width: ScreenAdapter.setWidth(1)))),
                        child: Row(
                          children: <Widget>[
                            Material(
                                //解决水波纹不显示的问题
                                child: Ink(
                                    child: InkWell(
                              onTap: () {
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    right: ScreenAdapter.setWidth(15),
                                    left: ScreenAdapter.setWidth(15)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.shopping_cart,
                                      size: 20,
                                    ),
                                    Text(
                                      "购物车",
                                      style: TextStyle(
                                          fontSize: ScreenAdapter.setSp(24)),
                                    )
                                  ],
                                ),
                              ),
                            ))),
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(
                                    right: ScreenAdapter.setWidth(15)),
                                child: GoodButton(
                                  color: Color.fromRGBO(253, 1, 0, 0.9),
                                  text: "加入购物车",
                                  cb: () {
                                    eventBus.fire(BuyOrCartEvent(1));
                                  },
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Container(
                                  margin: EdgeInsets.only(
                                      right: ScreenAdapter.setWidth(15)),
                                  child: GoodButton(
                                    color: Color.fromRGBO(255, 165, 0, 0.9),
                                    text: "立即购买",
                                    cb: () {
                                      eventBus.fire(BuyOrCartEvent(2));
                                    },
                                  )),
                            )
                          ],
                        ),
                      )),
                ],
              )
            : LoadingWidget(),
      ),
    );
  }
}
