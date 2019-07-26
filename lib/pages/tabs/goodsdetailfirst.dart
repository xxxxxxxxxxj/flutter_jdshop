import 'package:flutter/material.dart';
import 'package:flutter_jdshop/bean/bannerbean.dart';
import 'package:flutter_jdshop/bean/goodsdetailbean.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';
import 'package:flutter_jdshop/util/utils.dart';
import 'package:flutter_jdshop/view/banner_widget.dart';
import 'package:flutter_jdshop/view/goodbutton.dart';

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

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _goodsDetailData = widget._goodsDetailData;
    _bannerList.add(new BannerData.name(_goodsDetailData.pic));
  }

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
            _showBottomDialog();
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

  Widget _getAttrWidget(List<Attr> attrList, int index, setBottomState) {
    Attr attr = attrList[index];
    return Wrap(
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
                  setBottomState(() {
                    for (int i = 0; i < attrDataList.length; i++) {
                      attrDataList[i].isSelect = false;
                      if (i == index1) {
                        attrDataList[i].isSelect = true;
                      }
                    }
                  });
                  setState(() {
                    for (int i = 0; i < attrList.length; i++) {
                      var attrList2 = attrList[i].attrList;
                      for (int j = 0; j < attrList2.length; j++) {
                        if (attrList2[j].isSelect &&
                            !_localAttrList.contains(attrList2[j].cate)) {
                          _localAttrList.add(attrList2[j].cate);
                        }
                      }
                    }
                    _selectSpecifications = _localAttrList.join(",");
                  });
                },
                child: Chip(
                  backgroundColor:
                      attrData.isSelect ? Colors.red : Colors.black12,
                  label: Text(
                    Utils.getStr(attrData.cate),
                    style: TextStyle(
                        color: attrData.isSelect ? Colors.white : Colors.black,
                        fontSize: ScreenAdapter.setSp(24)),
                  ),
                ),
              ),
            );
          }),
        )
      ],
    );
  }

  void _showBottomDialog() {
    _localAttrList.clear();
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setBottomState) {
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
                    child: ListView.builder(
                        itemCount: _goodsDetailData.attr.length,
                        itemBuilder: (context, index) {
                          return _getAttrWidget(
                              _goodsDetailData.attr, index, setBottomState);
                        }),
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
                                  cb: () {
                                    print('加入购物车');
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
