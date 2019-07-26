import 'package:flutter/material.dart';
import 'package:flutter_jdshop/bean/bannerbean.dart';
import 'package:flutter_jdshop/bean/goodsspecifications.dart';
import 'package:flutter_jdshop/util/screenadapter.dart';
import 'package:flutter_jdshop/view/banner_widget.dart';
import 'package:flutter_jdshop/view/goodbutton.dart';

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
  List<GoodsSpecifications> _specificationsList =
      new List<GoodsSpecifications>();

  @override
  void initState() {
    super.initState();
    List<GoodsSpecificationsData> _dataList1 =
        new List<GoodsSpecificationsData>();
    _dataList1.add(new GoodsSpecificationsData(1, "白色"));
    _dataList1.add(new GoodsSpecificationsData(2, "黑加黑色"));
    _dataList1.add(new GoodsSpecificationsData(3, "黄色"));
    _dataList1.add(new GoodsSpecificationsData(4, "蓝靛紫色色"));
    _dataList1.add(new GoodsSpecificationsData(5, "灰蓝靛紫哦色"));
    _dataList1.add(new GoodsSpecificationsData(6, "紫色"));
    _dataList1.add(new GoodsSpecificationsData(7, "青色"));
    _specificationsList.add(new GoodsSpecifications("颜色：", _dataList1));
    List<GoodsSpecificationsData> _dataList2 =
        new List<GoodsSpecificationsData>();
    _dataList2.add(new GoodsSpecificationsData(1, "1寸"));
    _dataList2.add(new GoodsSpecificationsData(2, "33333寸"));
    _dataList2.add(new GoodsSpecificationsData(3, "186寸"));
    _dataList2.add(new GoodsSpecificationsData(4, "99999999寸"));
    _dataList2.add(new GoodsSpecificationsData(5, "91246139寸"));
    _dataList2.add(new GoodsSpecificationsData(6, "3寸"));
    _dataList2.add(new GoodsSpecificationsData(7, "9寸"));
    _specificationsList.add(new GoodsSpecifications("尺寸：", _dataList2));
    _specificationsList.add(new GoodsSpecifications("尺寸：", _dataList2));
    _specificationsList.add(new GoodsSpecifications("尺寸：", _dataList2));
    _specificationsList.add(new GoodsSpecifications("尺寸：", _dataList2));
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
                    _selectSpecifications,
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
                  _freight,
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

  void _showBottomDialog() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
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
                      itemCount: _specificationsList.length,
                      itemBuilder: (context, index) {
                        return Wrap(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  top: ScreenAdapter.setHeight(40)),
                              child: Text(
                                _specificationsList[index].title,
                                style: TextStyle(
                                    fontSize: ScreenAdapter.setSp(26),
                                    color: Colors.black),
                              ),
                            ),
                            Wrap(
                              children: List.generate(
                                  _specificationsList[index].dataList.length,
                                  (index1) {
                                return Container(
                                  margin: EdgeInsets.only(
                                      left: ScreenAdapter.setWidth(15)),
                                  child: Chip(
                                    label: Text(
                                      _specificationsList[index]
                                          .dataList[index1]
                                          .title,
                                      style: TextStyle(
                                          fontSize: ScreenAdapter.setSp(24)),
                                    ),
                                    padding: EdgeInsets.all(5),
                                  ),
                                );
                              }),
                            )
                          ],
                        );
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
  }
}
