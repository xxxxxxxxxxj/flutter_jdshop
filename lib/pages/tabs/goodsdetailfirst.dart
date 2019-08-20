import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_jdshop/bean/bannerbean.dart';
import 'package:flutter_jdshop/bean/goodsdetailbean.dart';
import 'package:flutter_jdshop/bean/prodcutbean.dart';
import 'package:flutter_jdshop/event/event.dart';
import 'package:flutter_jdshop/services/cartservice.dart';
import 'package:flutter_jdshop/util/log_util.dart';
import 'package:flutter_jdshop/util/object_util.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';
import 'package:flutter_jdshop/util/utils.dart';
import 'package:flutter_jdshop/view/banner_widget.dart';
import 'package:flutter_jdshop/view/goodbutton.dart';
import 'package:flutter_jdshop/view/goodsnum_widget.dart';
import 'package:flutter_jdshop/view/loading_widget.dart';

class GoodsDetailFirst extends StatefulWidget {
  GoodsDetailData _goodsDetailData;

  GoodsDetailFirst(this._goodsDetailData);

  @override
  State<StatefulWidget> createState() {
    return _GoodsDetailFirstState();
  }
}

class _GoodsDetailFirstState extends State<GoodsDetailFirst>
    with AutomaticKeepAliveClientMixin {
  GoodsDetailData _goodsDetailData;
  List<BannerData> _bannerList = new List<BannerData>();
  String _freight = "";
  String _selectSpecifications = "";
  List<String> _localAttrList = new List<String>();
  StreamSubscription<CartNumEvent> actionEventBus1;
  StreamSubscription<BuyOrCartEvent> actionEventBus;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _goodsDetailData = widget._goodsDetailData;
    _bannerList.add(new BannerData.name(_goodsDetailData.pic));
    actionEventBus = eventBus.on<BuyOrCartEvent>().listen((event) {
      LogUtil.e(event.toString());
      _showBottomDialog();
    });
    actionEventBus1 = eventBus.on<CartNumEvent>().listen((event) {
      LogUtil.e(event.toString());
      if (event.flag == 1) {
        _goodsDetailData.num = event.num;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    actionEventBus.cancel();
    actionEventBus1.cancel();
  }

  @override
  Widget build(BuildContext context) {
    ScreenAdapter.init(context);
    return ListView(
      children: <Widget>[
        //头部banner
        ObjectUtil.isNotEmpty(_bannerList)
            ? BannerWidget(_bannerList, 16 / 9)
            : LoadingWidget(),
        //间隔30像素
        SizedBox(
          height: ScreenAdapter.setHeight(30),
        ),
        Container(
            margin: EdgeInsets.only(
                left: ScreenAdapter.setWidth(15),
                right: ScreenAdapter.setWidth(15),
                bottom: ScreenAdapter.setHeight(30)),
            child: Text(
              Utils.getStr(_goodsDetailData.title),
              style: TextStyle(
                  fontSize: ScreenAdapter.setSp(36), color: Colors.black),
            )),
        Container(
            margin: EdgeInsets.only(
                left: ScreenAdapter.setWidth(15),
                right: ScreenAdapter.setWidth(15),
                bottom: ScreenAdapter.setHeight(30)),
            child: Text(
              Utils.getStr(_goodsDetailData.subTitle),
              style: TextStyle(
                  fontSize: ScreenAdapter.setSp(28), color: Colors.black26),
            )),
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
                        "¥${Utils.getStr(_goodsDetailData.price)}",
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
                        "¥${Utils.getStr(_goodsDetailData.oldPrice)}",
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
        InkWell(
          onTap: () {
            if (ObjectUtil.isNotEmpty(_goodsDetailData.attr)) {
              _showBottomDialog();
            }
          },
          child: Container(
              height: ScreenAdapter.setHeight(100),
              margin: EdgeInsets.only(
                left: ScreenAdapter.setWidth(15),
                right: ScreenAdapter.setWidth(15),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "已选：",
                    style: TextStyle(
                        fontSize: ScreenAdapter.setSp(24), color: Colors.black),
                  ),
                  Text(
                    Utils.getStr(_selectSpecifications),
                    style: TextStyle(
                        fontSize: ScreenAdapter.setSp(24),
                        color: Colors.black54),
                  ),
                ],
              )),
        ),
        Divider(
          height: ScreenAdapter.setHeight(1),
          color: Color.fromRGBO(233, 233, 233, 1),
        ),
        Container(
            height: ScreenAdapter.setHeight(100),
            margin: EdgeInsets.only(
              left: ScreenAdapter.setWidth(15),
              right: ScreenAdapter.setWidth(15),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "运费：",
                  style: TextStyle(
                      fontSize: ScreenAdapter.setSp(24), color: Colors.black),
                ),
                Text(
                  Utils.getStr(_freight),
                  style: TextStyle(
                      fontSize: ScreenAdapter.setSp(24), color: Colors.black54),
                ),
              ],
            )),
        Divider(
          height: ScreenAdapter.setHeight(1),
          color: Color.fromRGBO(233, 233, 233, 1),
        ),
      ],
    );
  }

  List<Widget> _getAttrWidget(List<Attr> attrList, setBottomState) {
    List<Widget> widgetList = List<Widget>();
    attrList.forEach((attr) {
      widgetList.add(Wrap(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: ScreenAdapter.setHeight(40)),
            child: Text(
              Utils.getStr(attr.cate),
              style: TextStyle(
                  fontSize: ScreenAdapter.setSp(26), color: Colors.black),
            ),
          ),
          Wrap(
            children: List.generate(attr.attrList.length, (index1) {
              List<AttrData> attrDataList = attr.attrList;
              AttrData attrData = attrDataList[index1];
              return Container(
                margin: EdgeInsets.only(left: ScreenAdapter.setWidth(15)),
                child: InkWell(
                  onTap: () {
                    _localAttrList.clear();
                    setBottomState(() {
                      for (int i = 0; i < attrDataList.length; i++) {
                        attrDataList[i].isSelect = false;
                        if (i == index1) {
                          attrDataList[i].isSelect = true;
                        }
                      }
                    });
                    for (int i = 0; i < attrList.length; i++) {
                      var attrList2 = attrList[i].attrList;
                      for (int j = 0; j < attrList2.length; j++) {
                        if (attrList2[j].isSelect) {
                          _localAttrList.add(attrList2[j].cate);
                        }
                      }
                    }
                    setState(() {
                      _selectSpecifications = _localAttrList.join(",");
                    });
                  },
                  child: Chip(
                    backgroundColor:
                        attrData.isSelect ? Colors.red : Colors.black12,
                    label: Text(
                      Utils.getStr(attrData.cate),
                      style: TextStyle(
                          color:
                              attrData.isSelect ? Colors.white : Colors.black,
                          fontSize: ScreenAdapter.setSp(24)),
                    ),
                  ),
                ),
              );
            }),
          )
        ],
      ));
    });
    return widgetList;
  }

  void _showBottomDialog() {
    _localAttrList.clear();
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return StatefulBuilder(builder: (_, setBottomState) {
            return GestureDetector(
              onTap: () {
                return false;
              },
              child: Stack(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(
                        bottom: ScreenAdapter.setHeight(100),
                        left: ScreenAdapter.setWidth(15),
                        right: ScreenAdapter.setWidth(15),
                        top: ScreenAdapter.setHeight(15)),
                    child: ListView(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _getAttrWidget(
                              _goodsDetailData.attr, setBottomState),
                        ),
                        Divider(
                          height: ScreenAdapter.setHeight(1),
                          color: Colors.black26,
                        ),
                        SizedBox(
                          height: ScreenAdapter.setWidth(15),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              Utils.getStr("数量"),
                              style: TextStyle(
                                  fontSize: ScreenAdapter.setSp(26),
                                  color: Colors.black),
                            ),
                            SizedBox(
                              width: ScreenAdapter.setWidth(15),
                            ),
                            GoodsNumWidget(1, _goodsDetailData.num, 0)
                          ],
                        )
                      ],
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        width: ScreenAdapter.setWidth(750),
                        height: ScreenAdapter.setHeight(100),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: ScreenAdapter.setWidth(15),
                                    right: ScreenAdapter.setWidth(15)),
                                child: GoodButton(
                                  color: Color.fromRGBO(253, 1, 0, 0.9),
                                  text: "加入购物车",
                                  cb: () async {
                                    bool isAdd = await CartService.addCart(
                                        ProductData.name(
                                      _goodsDetailData.sId,
                                      _goodsDetailData.title,
                                      _goodsDetailData.price,
                                      _goodsDetailData.pic,
                                      _selectSpecifications,
                                      _goodsDetailData.num,
                                      false,
                                    ));
                                    Navigator.of(context).pop();
                                    if (isAdd) {
                                      Scaffold.of(context).showSnackBar(
                                          new SnackBar(
                                              duration:
                                                  Duration(milliseconds: 1500),
                                              backgroundColor: Colors.green,
                                              content: new Text("添加成功")));
                                    } else {
                                      Scaffold.of(context).showSnackBar(
                                          new SnackBar(
                                              duration:
                                                  Duration(milliseconds: 1500),
                                              backgroundColor: Colors.red,
                                              content:
                                                  new Text("添加失败，您已添加过该商品")));
                                    }
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
                                      print('立即购买');
                                    },
                                  )),
                            )
                          ],
                        ),
                      )),
                ],
              ),
            );
          });
        });
  }
}
